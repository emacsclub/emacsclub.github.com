;; elisp introduction

;; Adapted from http://ergoemacs.org/emacs/elisp.html
;; Elisp basics

;; Emacs is just a big elisp interpreter.
;; This means that evaluation of elisp is something that is core to emacs.
;; C-x C-e runs eval-last-sexp. This will evaluate the expression under your cursor.
;; To try this, put your cursor over the closing paren in the elisp code below and type C-x C-e.
;; You should see "hi" in the echo area at the bottom of the buffer.

(message "hi")

;; All of the elsip documentation is readily available for you to examine.
;; The function to do this is describe-function.
;; You can try this by typing M-x describe-function and then typing message.

;; In addition to printing strings, we can print values as well.
;; This can be done similarly to how printf works

(message "I have %d fingers." 10) ; %d is for numbers
(message "Today is %s." "Friday") ; %s is for strings
(message "Here is a list: %S" (list 1 2 3)) ; %S is for any lisp expression

;; Math is done in polish notation.
;; This means that you put the operator, then the arguments.

;; 1 + 1
(+ 1 1)

;; 2 - 9
(- 2 9)

;; 10 - 9 - 3
(- 10 9 3)

;; 9^3
(expt 9 3)

;; 1 + (3 * 4 * (6.0 / 7))
(+ 1 (* 3 4 (/ 6.0 7)))

;; If you want a float instead of an integer, you can use 2.0 instead of 2.0

;; Integer result
(/ 7 2)

;; Float result
(/ 7 2.0)

;; All lisp programs are lists. A list is defined as things between parens.
;; Everything we have seen so far is a list,
;; but there are two kinds of lists in lisp.
;; The first is a quoted list. This tells the lisp interpreter not to do anything with it.

;; For example,
'(a b c)
;; is a quoted list.
;; In a list without the leading apostrophe, the first element is special.
;; The first element of the list is a function as we have seen before.
;; For example,
(+ 1 2)

;; + is a function that operates on the rest of the list
;; Also, in
(list 'ass 'bsss 'css)

;; list is a function that creates a quoted list from the remaining elements.

;; List functions
;; Length
(length '(1 2 3 4)) ; => 4

;; cons
(cons 0 '(1 2 3 4)) ; => (0 1 2 3 4)

;; append
(append '(0 1 2) '(3 4)) ; => (0 1 2 3 4)

;; car "first element"
(car '(0 2 3 4)) ; => 0

;; nth
(nth 2 '(0 1 2 3 4)) ; => 2

;; cdr "rest of the elements"
(cdr '(0 1 2 3 4)) ; => (1 2 3 4)

;; True and False
;; In elsip, the symbol nil is false and everything else is true.
;; Also, nil is equivalent to the empty list. i.e. ()

(if nil "true" "false") ; => "false"
(if () "true" "false") ; => "false"
(if '() "true" "false") ; => "false"
(if (list) "true" "false")  ; => "false"

(if t "true" "false") ; => "true"
(if 0 "true" "false") ; => "true"
(if "" "true" "false") ; => "true"
(if [] "true" "false") ; => "true". the [] is a vector of 0 elements

;; if is a function that takes a condition, then, and else.

;; Boolean functions
(and t nil) ; => nil
(or t nil) ; => t

;; Comparison functions
(< 3 4)
(> 3 4)
(= 3 4)
(= 3 3.0) ; => t
(/= 3 4)

(string-equal "this" "this") ; => t

;; The equal function
;; testing if two values have the same datatype and value.
(equal "abc" "abc") ; => t
(equal 3 3) ; => t
(equal 3.0 3.0) ; => t
(equal 3 3.0) ; => nil. Because datatype doesn't match.

;; testing equality of lists
(equal '(3 4 5) '(3 4 5))  ; => t
(equal '(3 4 5) '(3 4 "5")) ; => nil

;; testing equality of symbols
(equal 'abc 'abc) ; => t

;; Global and local variables

;; To make a new global variable, we use the setq function.

(setq a 10)

(message "The number we stored is %d" a)

;; Set many variables at once
(setq b 29 c 59 d 48)

;; Local variables are created by using let

(let (a)
  (setq a 3)
  (+ a 9)
  )

(let ((a 3) (b 2) (c "true"))
  (+ a 9)
  )



;; While
(setq x 0)

(while (< x 4)
  (print (format "yay %d" x))
  (setq x (1+ x))
  )

;; Block of expressions

(progn (message "hi") (message "lo"))

;; Defining functions
;; You can create new functions using defun

(defun yay ()
  "Insert \"Yay!\" at cursor position."
  (interactive)
  (insert "Yay!"))

;; Evaluate the function and then run it with M-x yay

(defun myFunction (myArg)
  "Prints the argument"
  (interactive "p")
  (message "Your argument is: %d" myArg)
  )

;; the "r" in (interactive "r") notes that we will be using the buffer;s begin/end text selection positions as arguments.


(defun myFunction (myStart myEnd)
  "Prints region start and end positions"
  (interactive "r")
  (message "Region begin at: %d, end at: %d" myStart myEnd)
  )

;; Interactive means that the function can be called interactively and you can pass arguments to it.

;; "n" prompts the user for a number
;; "s" prompts the user for a string
;; "r", takes the beginning and ending positions of the current region

;; Here is a template for elisp functions
(defun myCommand ()
  "One sentence summary of what this command do.

More detailed documentation here."
  (interactive)
  (let (localVar1 localVar2 …)
                                        ; do something here …
                                        ; …
                                        ; last expression is returned
    )
  )


;; ==============================================================================================

;; Now you try



;; Write a test function that takes a result and an expected value and lets you know if you were correct.

(defun test (result expected)
  "This function tests the result"
  (if (equal result expected)
      (progn
        (message "Success!")
        t
        )
    (progn
      (message "you suck!")
      nil
      )
    )
  )

(let ((correct 0) (wrong 0))
  (if (test 1 1) (setq correct (1+ correct)) (setq wrong (1+ wrong)))
  (if (test 1 2) (setq correct (1+ correct)) (setq wrong (1+ wrong)))
  (message "You got %d correct and %d wrong" correct wrong)
  )


;; Write a function that inserts a <p></p> tag

(defun insert-p-tag ()
  "Insert a <p></p> tag"

  )

;; Write a function that googles whatever word is under your cursor
(defun google-it ()
  "Look up the word under cursor in a browser."
)

;; Write a fold
(defun fold (f x list)
  "Recursively applies (F i j) to LIST starting with X.
For example, (fold F X '(1 2 3)) computes (F (F (F X 1) 2) 3)."
  )

(defun sum2 (x y) (+ x y))
(test (fold 'sum2 0 '(2 3 4 5 6)) 20)
