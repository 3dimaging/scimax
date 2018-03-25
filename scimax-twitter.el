;;; scimax-twitter.el --- Twitter functions

;;; Commentary:
;;
;; Install the commandline twitter from https://github.com/sferik/t
;; There was a bug described in https://github.com/sferik/t/issues/395
;; I installed an older version like this (uses Ruby).
;; gem install t -v 2.10
;;
;; Then run: t authorize
;;
;; to setup authorization for your twitter account.
;;
;; Send a tweet from a program: `scimax-twitter-update'.
;; Reply to a tweet from a program: `scimax-twitter-reply'
;;
;; Tweet from an org headline: `scimax-twitter-tweet-headline'
;;
;; Tweet a subtree as a thread: `scimax-twitter-org-subtree-tweet-thread'
;; TODO: check for lengths before trying to send.

(require 'scimax-functional-text)

;; * Hashtag functional text
(scimax-functional-text
 "\\(^\\|[[:punct:]]\\|[[:space:]]\\)\\(?2:#\\(?1:[[:alnum:]]+\\)\\)"
 (lambda ()
   (browse-url (format "https://twitter.com/hashtag/%s" (match-string 1))))
 :grouping 2
 :face (list 'org-link)
 :help-echo "Click me to open hashtag.")

;; * Twitter handles
(scimax-functional-text
 "\\(^\\|[[:punct:]]\\|[[:space:]]\\)\\(?2:@\\(?1:[[:alnum:]]+\\)\\)"
 (lambda ()
   (browse-url (format "https://twitter.com/%s" (match-string 1))))
 :grouping 2
 :face (list 'org-mlink)
 :help-echo "Click me to open username.")

(defvar scimax-twitter-usernames nil
  "List of usernames that either you follow or that follow you.")

(defun scimax-twitter-insert-username (&optional reload)
  (interactive "P")
  (unless (or reload scimax-twitter-usernames)
    (setq scimax-twitter-usernames (-uniq (append (process-lines "t" "followings")
						  (process-lines "t" "followers")))))
  (insert "@" (ivy-read "Username: " scimax-twitter-usernames)))


;; * Tweet functions

(defun scimax-twitter-update (msg &optional file)
  "Post MSG as a tweet with an optional media FILE.
Returns the msgid for the posted tweet or the output from t."
  (let* ((output (apply 'process-lines `("t" "update" ,msg
					 ,@(when file '("-f"))
					 ,@(when file `(,file)))))
	 (last-line (car (last output))))
    (if (string-match "`t delete status \\([0-9]*\\)`" last-line)
	(match-string-no-properties 1 last-line)
      last-line)))


(defun scimax-twitter-reply (msg msgid &optional file)
  "Reply MSG to tweet with MSGID and optional media FILE.
Returns the msgid for the posted tweet or the output from t."
  (let* ((output (apply 'process-lines `("t" "reply" ,msgid ,msg
					 ,@(when file '("-f"))
					 ,@(when file `(,file)))))
	 (last-line (car (last output))))
    (if (string-match "`t delete status \\([0-9]*\\)`" last-line)
	(match-string-no-properties 1 last-line)
      last-line)))


(defmacro scimax-twitter-tweet-thread (&rest tweets)
  "Each tweet is a list of msg and optional file.
After the first tweet, each remaining tweet is a reply to the
last one."
  ;; Send the first one.
  (let (msgid
	(tweet (pop tweets)))
    (setq msgid (apply 'tweet (if (stringp tweet)
				  (list tweet)
				tweet)))
    ;; now send the rest of them
    (while tweets
      (setq tweet (pop tweets)
	    msgid (apply 'tweet-reply `(,msgid ,@(if (stringp tweet)
						     (list tweet)
						   tweet)))))))


;; * Twitter - org integration

(defun scimax-twitter-org-reply-p ()
  "For the current headline, determine if it is a reply to another tweet.
It is if the previous heading has TWITTER_MSGID property, and the
current headline is tagged as part of a tweet thread. Returns the
id to reply to if those conditions are met."
  (let ((tags (mapcar 'org-no-properties (org-get-tags-at))))
    (and (-contains?  tags "tweet")
	 (-contains? tags "thread")
	 (save-excursion
	   (unless (looking-at org-heading-regexp)
	     (org-back-to-heading))
	   (org-previous-visible-heading 1)
	   (org-entry-get nil "TWITTER_MSGID")))))


(defun scimax-twitter-org-tweet-components ()
  "Get the components required for tweeting a headline.
This is a list of (message reply-id file) where message is a
string that will be the tweet, reply-id is a string of the id to
reply to (it may be nil), and file is an optional media file to
attach to the tweet. If there are code blocks with a :gist in the
header, they will be uploaded as a gist, and the link added to
the msg. "
  (let (msg
	reply-id
	file
	gists
	cp
	next-heading)

    (save-excursion
      (unless (looking-at org-heading-regexp)
	(org-back-to-heading))
      (setq cp (point)
	    msg (nth 4 (org-heading-components))
	    reply-id (scimax-twitter-org-reply-p)))

    ;; check for files to attach
    (save-excursion
      (when (looking-at org-heading-regexp) (forward-char))
      (setq next-heading (re-search-forward org-heading-regexp nil t 1)))

    (save-restriction
      (narrow-to-region cp (or next-heading (point-max)))
      (setq file (car (org-element-map (org-element-parse-buffer) 'link
			(lambda (link)
			  (when
			      (and
			       (string= "file" (org-element-property :type link))
			       (f-ext? (org-element-property :path link) "png"))
			    (org-element-property :path link))))))
      ;; src-blocks
      (setq gists (org-element-map (org-element-parse-buffer) 'src-block
		    (lambda (src)
		      (when (and (stringp (org-element-property :parameters src))
				 (s-contains? ":gist" (org-element-property :parameters src)))
			(save-excursion
			  (goto-char (org-element-property :begin src))
			  (org-edit-special)
			  (gist-buffer)
			  (org-edit-src-abort)
			  (org-no-properties (pop kill-ring))))))))
    (when gists (setq msg (s-concat msg " " (s-join " " gists))))
    (list msg reply-id file)))


(defun scimax-twitter-tweet-headline (&optional force)
  "Tweet a headline.
The headline itself is the tweet, and the first image is
attached. If the headline is in a :tweet:thread:, reply if
necessary. Adds properties to the headline so you know what was
done."
  (interactive "P")
  (unless force
    (when (org-entry-get nil "TWITTER_MSGID")
      (user-error "This headline has already been tweeted.")))

  (let* ((components (scimax-twitter-org-tweet-components))
	 (msgid (if (not (null (nth 1 components)))
		    ;; reply
		    (apply 'scimax-twitter-reply components)
		  (scimax-twitter-update (nth 0 components) (nth 2 components)))))
    (when (not (null (nth 1 components)))
      (org-entry-put nil "TWITTER_IN_REPLY_TO" (nth 1 components)))
    (org-entry-put nil "TWITTER_MSGID" msgid)
    (org-entry-put nil "TWITTER_URL" (format "https://twitter.com/%s/status/%s"
					     (car (process-lines "t" "accounts"))
					     msgid))
    (message "%s" components)))


(defun scimax-twitter-org-subtree-tweet-thread ()
  "Tweet the subtree as a thread."
  (interactive)
  (save-restriction
    (org-narrow-to-subtree)
    (save-excursion
      (goto-char (point-min))
      (while (looking-at org-heading-regexp)
	(scimax-twitter-tweet-headline)
	(org-next-visible-heading 1)))))


(defun scimax-twitter-clear-thread-properties ()
  "Clear the Twitter properties in the subtree."
  (interactive)
  (save-restriction
    (org-narrow-to-subtree)
    (save-excursion
      (goto-char (point-min))
      (while (looking-at org-heading-regexp)
	(org-entry-delete nil "TWITTER_URL")
	(org-entry-delete nil "TWITTER_MSGID")
	(org-entry-delete nil "TWITTER_IN_REPLY_TO")
	(org-next-visible-heading 1)))))


(provide 'scimax-twitter)

;;; scimax-twitter.el ends here
