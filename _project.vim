runtime! projects/ruby.vim

AckIgnore doc/

autocmd BufEnter *.rb RunCommand !ruby -Ilib %
