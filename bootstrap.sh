#!/usr/bin/env bash

set -eo pipefail

if [ ! -d /usr/local/src/ccl ]; then
  wget ftp://ftp.clozure.com/pub/release/1.10/ccl-1.10-linuxx86.tar.gz -O - | tar -xvz
  find ccl -name .svn -print0 | xargs -0 rm -rf

  # XXX: /usr/local/src is the default "CCL_DEFAULT_DIRECTORY"
  mv ccl /usr/local/src
fi

if [ ! "$(readlink -f /usr/local/bin/ccl)" = "/usr/local/src/ccl/scripts/ccl64" ]; then
  rm -f /usr/local/bin/ccl
  ln -s /usr/local/src/ccl/scripts/ccl64 /usr/local/bin/ccl
fi

cat <<EOF > setup.lisp
$(wget -q -O - http://beta.quicklisp.org/quicklisp.lisp)
(unless (member :quicklisp *features*)
  (quicklisp-quickstart:install))
(let ((ql-util::*do-not-prompt* t))
  (ql:add-to-init-file))
(ql:quickload "quicklisp-slime-helper")
(ccl:quit 0)
EOF

ccl --load setup.lisp
