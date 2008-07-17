(load-library "blorg")

(defvar blog-root (concat user-home "/org/blog/"))
(defvar blog-files (concat blog-root "files/"))
(defvar blog-output (concat blog-root "output/"))

(defun publish-blog()
  "Publishes your blog, by copying the required files to the
   output directory and calling org-publish and blorg-publish"
  (interactive)
  (blorg-publish t)
  (org-publish-all)
  (shell-command (concat "cp -rf " blog-files "/* " blog-output)))

;; todo unify these two blocks into one.
;(setq blorgv-author "Rick Moynihan")
;(setq blorgv-email "rick@sourcesmouth.co.uk")
;(setq blorgv-blog-url "http://sourcesmouth.co.uk/blog/")
;(setq blorgv-blog-title "The Sources Mouth")
;(setq blorgv-homepage "http://sourcesmouth.co.uk/home/")
;(setq blorgv-publish-d "~/org/blog/output")

(setq blorg-default-options `(
                              :created "<2007-07-15 Sun>" 
                              :modified "%:y-07-14 16:50:14 6" 
                              :homepage "http://sourcesmouth.co.uk/home/" 
                              :language "en" 
                              :encoding "UTF-8" 
                              :keywords "opensource freesoftware software technology network internet socialsoftware culture programming " 
                              :html-css "index.css" 
                              :xml-css "http://www.blogger.com/styles/atom.css" 
                              :feed-type "atom" 
                              :done-string "DONE" 
                              :number-of-posts "12" 
                              ))


      

(setq blorg-echos-list (quote ("")))
(setq blorg-put-full-post (quote (post feed)))
(setq blorg-reverse-posts-order nil)
(setq blorg-strings (quote (:index-page-name "index" 
                            :page-extension ".html" 
                            :feed-extension ".xml" 
                            :meta-robots "index,follow" 
                            :read-more "..." 
                            :time-format "%A, %B %d %Y" 
                            :title-separator " - ")))

(setq blorg-parg-in-headlines 1000)
(setq blorg-post-number-per-page (quote ((index . 10) (feed . 10) (tag . 10) (month . 100))))
(setq blorg-use-third-party-feed "http://feeds.feedburner.com/TheSourcesMouth")

(defun sourcesmouth-gen-header(index-url page-title mailto author)
  "Generate a header"
  (concat "<body class=\"body\">

<div id=\"header\">
  <h1><a href=\"" index-url "\">" page-title "</a></h1> 
  <div id=\"blog-author\">
    <h3><a href=\"" mailto "\">" author "</a></h3>
  </div>
</div>"))

;; TODO check generation of URL consisistent on pages and index.

(defun sourcesmouth-gen-right-col (tags previous-posts archives)
  "Generate the right column"
  (concat "
	  <div id=\"right\" class=\"column\">
		  <h2>About</h2>
                  <p>A blog on ideas, technology, open source and their cultural impact.</p>
                  <p><a href=\"" blorgv-blog-url "pages/about-me.html\">About Me</a></p>
                  <h2>Tags</h2>"
          tags 
          "<div id=\"container\">
                    <h2>Yum</h2>
                    <p><a href=\"http://del.icio.us/InkyHarmonics/\">del.icio.us</a></p>
           </div>

          <h2>Previously</h2>"
          previous-posts
          archives
          "<script type=\"text/javascript\" 
                   src=\"http://del.icio.us/feeds/json/InkyHarmonics?count=10\"></script>
           <script type=\"text/javascript\" src=\"delicious.js\"/></script>

	  </div>"))

(setq my-blorg-header 
      (sourcesmouth-gen-header "(blorg-insert-index-url)" 
                               "(blorg-insert-page-title)"
                               "(blorg-insert-mailto-email)"
                               "(blorg-insert-author)"))

(setq my-blorg-left-col 
"
	  <div id=\"left\" class=\"column\">
<!-- 	    <h3>Foo Bar!</h3> -->
<!-- 	    <p> -->
<!-- 	      Stuff can go here... -->

<!-- 	    </p> -->
	  </div>
")

(setq my-blorg-right-col 
      (sourcesmouth-gen-right-col "(blorg-insert-tags-as-cloud)" 
                                  "(blorg-insert-previous-posts)"
                                  "(blorg-insert-archives)"))

(setq sourcesmouth-right-col 
      (sourcesmouth-gen-right-col "<!-- TODO TAGS GO HERE -->" 
                                  "<!-- TODO PREVIOUS POSTS HERE -->"
                                  "<!-- TODO ARCHIVES HERE -->"))

;; todo somehow unify this with right-col
(setq my-blorg-right-col-post-page
"
	  <div id=\"right\" class=\"column\">
		  <h2>About</h2>
                  <p>A blog on ideas, technology, open source and their cultural impact.</p>
                  <p><a href="./pages/about-me.html">About Me</a></p>
                  <h2>Tags</h2>
                  (blorg-insert-tags-as-cloud)
                  <div id=\"container\">
                    <h2>Yum</h2>
                    <p><a href=\"http://del.icio.us/InkyHarmonics/\">del.icio.us</a></p>
                  </div>

                  <h2>Previously</h2>
                  (blorg-insert-archives)

<script type=\"text/javascript\" 
        src=\"http://del.icio.us/feeds/json/InkyHarmonics?count=10\"></script>
<script type=\"text/javascript\" src=\"delicious.js\"/>
</script>

	  </div>")


(setq my-blorg-centre-col "
<div id=\"center\" class=\"column\">
 (blorg-insert-content)
</div> <!-- center, column -->")

(setq my-blorg-post-page-template (concat 
                                      my-blorg-header 
                                      my-blorg-centre-col 
                                      my-blorg-left-col 
                                      my-blorg-right-col-post-page
                                      "</body>"))

(setq my-blorg-post-template "
<div class=\"post\">

<div class=\"post-title\">
  <h2><a href=\"(blorg-insert-post-url)\">(blorg-insert-post-title)</a></h2>
</div>

<div class=\"post-infos\">
 (blorg-insert-post-author)
 (blorg-insert-post-dates)
 (blorg-insert-post-tags)
</div>

<div class=\"post-content\">
 (blorg-insert-post-content)
</div>

 (blorg-insert-post-echos)

</div>")

(setq my-blorg-right-col 
      (sourcesmouth-gen-right-col "(blorg-insert-tags-as-cloud)" 
                                  "(blorg-insert-previous-posts)"
                                  "(blorg-insert-archives)"))

(setq my-blorg-template (concat 
                            my-blorg-header 
                            my-blorg-centre-col
                            my-blorg-left-col
                            my-blorg-right-col
                            "</body>"))

(setq my-blorg-tag-page-template my-blorg-template)
(setq my-blorg-month-template  my-blorg-template)

(setq blorg-index-template my-blorg-template)
(setq blorg-month-page-template my-blorg-month-template)
(setq blorg-tag-page-template my-blorg-tag-page-template)
(setq blorg-post-page-template my-blorg-post-page-template)
(setq blorg-post-template my-blorg-post-template)

(setq sourcesmouth-page-header
      (sourcesmouth-gen-header blorgv-blog-url
                               blorgv-blog-title
                               blorgv-email
                               blorgv-author))

(add-to-list 'org-publish-project-alist 
             `("blog-pages"
               :base-directory "~/org/blog/pages/"
               :base-extension "org"
               :publishing-directory "~/org/blog/output/pages/"
               :section-numbers nil
               :table-of-contents nil
               :style "<link rel=stylesheet href=\"../index.css\" type=\"text/css\">"
               :preamble ,(concat sourcesmouth-page-header "<div id=\"center\" class=\"column\">")
               :auto-postamble nil
               :postamble ,(concat "</div><div id=\"left\" class=\"column\"></div>" my-blorg-left-col my-blorg-right-col)))


;; 
;; Block by Bastien for linking to youtube content with dynamic blocks
;; doesn't work properly.
;; 

;; #+BEGIN: youtube :url "http://www.youtube.com/watch?v=fu8rAWciQNs"
;; #+END:

(defun org-dblock-write:youtube (params)
 "Insert a header from a file."
 (let ((url (plist-get params :url)))
   (insert
    (format "<object width=\"425\" height=\"355\"><param name=\"movie\"
value=\"%s\"></param><param name=\"wmode\"
value=\"transparent\"></param><embed src=\"%s\"
type=\"application/x-shockwave-flash\" wmode=\"transparent\"
width=\"425\" height=\"355\"></embed></object>" url url))))