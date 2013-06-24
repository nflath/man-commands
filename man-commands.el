;;; man-commands.el --- Add interactive commands for every manpages installed in your computer.

;; Copyright (C) 2013 Nathaniel Flath <nflath@gmail.com>

;; Author: Nathaniel Flath <nflath@gmail.com>
;; URL: http://github.com/nflath/man-commands
;; Version: 1.0

;; This file is not part of GNU Emacs.

;;; Commentary:

;; I usually try to do M-x man-mail, or whatever command I'm trying, before
;; going to M-x max and entering the command.  The following actually installs
;; all of the commands you can man as interactive command.

;;; Installation:

;; To install, put this file somewhere in your load-path and add the following
;; to your .emacs file:
;;(require 'man-commands)

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(defvar man-commands-man-dir "/usr/share/man/" "Location of man files on your system")

(defun man-commands-update-commands ()
  (interactive)
  (let ((man-page-list nil))
    (mapc (lambda (dir)
            (message dir)
            (mapcar
             (lambda (file) (add-to-list 'man-page-list
                                         (before-first "\\." (after-last "/" file))))
             (directory-files-recursive (concat man-commands-man-dir dir))))
          (remove-if-not (lambda (elt) (string-match "man" elt))
                         (directory-files man-commands-man-dir)))
    (mapcar (lambda (elt)
              (eval
               `(defun ,(intern (concat "man-" elt)) ()
                  (interactive)
                  (man ,elt))))
            man-page-list)))

(man-commands-update-commands)
(provide 'man-commands)
