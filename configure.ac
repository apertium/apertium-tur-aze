
AC_PREREQ(2.52)

AC_INIT([apertium-tur-aze], [0.1.0], [ggrossi@gmail.com])
AM_INIT_AUTOMAKE([apertium-tur-aze], [0.1.0], no-define)
AC_PROG_LN_S
AC_PROG_AWK

m4_define([required_apertium_version], [3.2.0])
PKG_CHECK_MODULES(APERTIUM,   apertium >= required_apertium_version, [], [PKG_CHECK_MODULES(APERTIUM,   apertium-3.2 >= required_apertium_version)])
                          

#PKG_CHECK_MODULES(HFST, hfst >= 3.0.0)

AC_PATH_PROG(CGCOMP, cg-comp, no)
if test x$ac_cv_path_CGCOMP = x
then
  AC_MSG_ERROR([You don't have cg-comp installed.])
fi
if test x$ac_cv_path_CGPROC = xno
then
  AC_MSG_ERROR([You don't have cg-comp installed.])
fi

AC_PATH_PROG(CGPROC, cg-proc, no)
if test x$ac_cv_path_CGPROC = x
then
  AC_MSG_ERROR([You don't have cg-proc installed.])
fi
if test x$ac_cv_path_CGPROC = xno
then
  AC_MSG_ERROR([You don't have cg-proc installed.])
fi

AC_OUTPUT([Makefile morph-az/Makefile morph-tr/Makefile])
