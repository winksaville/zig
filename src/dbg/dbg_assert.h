#ifndef DBG_ASSERT_H
#define DBG_ASSERT_H

#include "dbg_common.h"

DBG_EXTERN_C_BEGIN

#if defined(DBG_ENABLED)
  #define dbg_assert(dc, expr) \
     ((expr) ? (void)0 : \
        dbg_assert_fail(dc, #expr, __FILE__, __LINE__, __func__))
#else
  #define dbg_assert(dc, expr) ((void)0)
#endif

void dbg_assert_fail(dbg_ctx_t* dc, const char*, const char* f, size_t ln, const char* fn);


#if defined(__cplusplus)
    #define dbg_static_assert(bool_constexpr, str) static_assert(bool_constexpr, str)
#else
    #define dbg_static_assert(bool_constexpr, str) _Static_assert(bool_constexpr, str)
#endif

DBG_EXTERN_C_END

#endif
