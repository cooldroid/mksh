/**	$MirBSD: src/bin/ksh/conf-end.h,v 2.9 2004/12/31 17:29:28 tg Exp $ */
/*	$OpenBSD: conf-end.h,v 1.2 1996/08/25 12:37:58 downsj Exp $	*/

#ifndef CONF_END_H
#define CONF_END_H

/* Include job control? */
#define JOBS 1

/* Include complex history? */
#define COMPLEX_HISTORY

/* Specify default $ENV? */
/* #undef DEFAULT_ENV */

/*
 * The above are defined for mirbsdksh via external
 * means, such as this header ;-)
 * End of configuration stuff for PD ksh.
 */

#if SIZEOF_INT < 4
# error "int cannot hold 32 bit"
#endif

/*
 * if you don't have mmap() you can't use Peter Collinson's history
 * mechanism.  If that is the case, then define EASY_HISTORY
 */
#if !defined(COMPLEX_HISTORY) || !defined(HAVE_MMAP) || !defined(HAVE_FLOCK)
# undef COMPLEX_HISTORY
# define EASY_HISTORY			/* sjg's trivial history file */
#endif

/* Can we safely catch sigchld and wait for processes? */
#if defined(HAVE_WAITPID) || defined(HAVE_WAIT3)
# define JOB_SIGS
#endif

#if !defined(JOB_SIGS) || !(defined(POSIX_PGRP) || defined(BSD_PGRP))
# undef JOBS /* if no JOB_SIGS, no job control support */
#endif

#ifdef HAVE_SYS_PARAM_H
# include <sys/param.h>
#else
# ifdef HAVE_SYS_TYPES_H
#  include <sys/types.h>
# endif /* HAVE_SYS_TYPES_H */
#endif /* HAVE_SYS_PARAM_H */

#ifdef HAVE_STDINT_H
# include <stdint.h>
#endif

#ifdef HAVE_GCC_FUNC_ATTR
# define GCC_FUNC_ATTR(x)	__attribute__((x))
# define GCC_FUNC_ATTR2(x,y)	__attribute__((x,y))
#else
# define GCC_FUNC_ATTR(x)
# define GCC_FUNC_ATTR2(x,y)
#endif /* HAVE_GCC_FUNC_ATTR */

#ifdef HAVE_STDBOOL_H
#include <stdbool.h>
#else
#if defined(__GNUC__) && __GNUC__ >= 3
/* Support for _C99: type _Bool is already built-in. */
#define false	0
#define true	1
#else
typedef enum {
	false = 0,
	true = 1
} _Bool;
#define	false	false
#define	true	true
#endif
#define bool _Bool
#endif

#endif	/* ndef CONF_END_H */
