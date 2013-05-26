
(import [or = + - / *] "../runtime")

(def version "0.0.1")

;; Public functions, credits: <http://goo.gl/mGr0K>

(defn average [v1 v2] (/ (+ v1 v2) 2))

(defn square [n] (* n n))

(defn abs [n] (if (< n 0) (* -1 n) n))

(defn sqrt [x]
 "Function that maps the set of non-negative real numbers onto itself. In
 geometrical terms, the square root function maps the area of a square to its
 side length. The square root of x is rational if and only if x is a rational
 number that can be represented as a ratio of two perfect squares"
  (def improve (fn [guess]
    (average guess (/ x guess))))
  (def good-enough? (fn [guess]
    (< (abs (- (square guess) x)) 0.0000000001)))
  (def tryit (fn [guess]
    (if (good-enough? guess)
      guess
      (tryit (improve guess)))))
  (tryit 1))

(. console log (sqrt 25))


(defn factorial
 "The factorial of a non-negative integer n, denoted by n!, is the product of
 all positive integers less than or equal to n. There are n! ways to arrange n
 distinct objects into a sequence (i.e., permutations of the set of objects)."
 [n] (if (= n 0)
            1
            (* n (factorial (- n 1)))))

;(. console log (factorial 6))

(defn ack
"Ackermann function, evaluation which always terminates. However, the recursion
is bounded because in each recursive application either m decreases, or m
remains the same and n decreases. Each time that n reaches zero, m decreases, so
m eventually reaches zero as well. "
 [m n] (if (= m 0)
           (+ n 1)
                 (if (= n 0)
                            (ack (- m 1) 1)
                            (ack (- m 1) (ack m (- n 1))))))

;(. console log (ack 2 15))

(defn fib
"The first two numbers in the Fibonacci sequence are 0 and 1, and each
subsequent number is the sum of the previous two. The sequence Fn of Fibonacci
numbers is defined by the recurrence relation."
  [n] (if (= n 0)
             0
             (if (= n 1)
                          1
                         (+ (fib (- n 1)) (fib (- n 2))))))

;(. console log (fib 8))

(defn gcd
 "Greatest common divisor. The largest positive integer that divides the numbers
 without a remainder."
  [a b] (if (= a b)
               a
               (if (> a b)
                            (gcd (- a b) b)
                            (gcd a (- b a)))))

;(. console log (gcd 330 720))

(defn dbl
"Curried function passed as a parameter. dbl is a dubbling function."
 [x] (* 2 x))
