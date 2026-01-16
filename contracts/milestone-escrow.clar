;; ======================================================
;; TreasurySweeper
;; Collects and forwards funds to a treasury address
;; ======================================================

(define-data-var admin principal tx-sender)
(define-data-var treasury principal tx-sender)
(define-data-var paused bool false)

;; Errors
(define-constant ERR-NOT-AUTHORIZED u100)
(define-constant ERR-PAUSED u101)
(define-constant ERR-ZERO-AMOUNT u102)

;; ----------------------------
;; Helpers
;; ----------------------------

(define-read-only (is-admin)
  (is-eq tx-sender (var-get admin))
)

(define-private (assert-not-paused)
  (begin
    (asserts! (not (var-get paused)) (err ERR-PAUSED))
    (ok true)
  )
)

;; ----------------------------
;; Admin Functions
;; ----------------------------

(define-public (set-treasury (new-treasury principal))
  (begin
    (asserts! (is-admin) (err ERR-NOT-AUTHORIZED))
    (var-set treasury new-treasury)
    (ok true)
  )
)

(define-public (pause (flag bool))
  (begin
    (asserts! (is-admin) (err ERR-NOT-AUTHORIZED))
    (var-set paused flag)
    (ok true)
  )
)

;; Emergency withdrawal (admin only)
(define-public (withdraw-stx (amount uint))
  (begin
    (asserts! (is-admin) (err ERR-NOT-AUTHORIZED))
    (stx-transfer? amount (as-contract tx-sender) (var-get treasury))
  )
)

;; Inline the paused check directly using asserts! instead of calling assert-not-paused
;; This avoids the "intermediary responses" error by checking the Result before the next statement
(define-public (sweep-stx)
  (begin
    (asserts! (not (var-get paused)) (err ERR-PAUSED))
    (let ((bal (stx-get-balance (as-contract tx-sender))))
      (asserts! (> bal u0) (err ERR-ZERO-AMOUNT))
      (stx-transfer? bal (as-contract tx-sender) (var-get treasury))
    )
  )
)
