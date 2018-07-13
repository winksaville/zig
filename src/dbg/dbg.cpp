#include "dbg.h"
#include "dbg_assert.h"

#include <cstdlib>

void dbg_ctx_common_init(dbg_ctx_common_t* dcc, uint64_t id,
    size_t number_of_bits)
{
  dbg_ctx_t* dc = (dbg_ctx_t*)dcc;
  dbg_assert(dc, dcc != NULL);
  dcc->id = id;
  dcc->number_of_bits = number_of_bits;
  size_t bits_size =
    ((number_of_bits + sizeof(size_t) - 1) / sizeof(size_t)) * sizeof(size_t);
  if(bits_size != 0)
  {
    dcc->bits = (size_t*)calloc(sizeof(size_t), bits_size);
    dbg_assert(dc, dcc->bits != NULL);
  }
  dbg_assert(dc, sizeof(dcc->bits[0]) == sizeof(size_t));
  dbg_assert(dc, dcc->fun_name == NULL);
  dbg_assert(dc, dcc->line_num == 0);
  dbg_assert(dc, dcc->dbg_ctx_impl_destroy == NULL);
  dbg_assert(dc, dcc->dbg_ctx_impl_vprintf == NULL);
}

void  dbg_ctx_common_destroy(dbg_ctx_common_t* dcc)
{
  if(dcc->bits != NULL)
    free(dcc->bits);
}

dbg_ctx_t* dbg_ctx_create(size_t number_of_bits)
{
  dbg_ctx_common_t* dcc =
    (dbg_ctx_common_t*)calloc(1, sizeof(dbg_ctx_common_t));
  dbg_ctx_common_init(dcc, DBG_CTX_ID_COMMON, number_of_bits);
  return (dbg_ctx_t*)dcc;
}

void dbg_ctx_destroy(dbg_ctx_t* dc)
{
  dbg_ctx_common_t* dcc = (dbg_ctx_common_t*)dc;
  if(dcc != NULL)
  {
    dbg_ctx_common_destroy(dcc);

    if(dcc->dbg_ctx_impl_destroy != NULL)
      dcc->dbg_ctx_impl_destroy(dc);
  }
}

void dbg_set_bit(dbg_ctx_t* dc, size_t bit_idx, bool bit_value)
{
  dbg_sb(dc, bit_idx, bit_value);
}

bool dbg_get_bit(dbg_ctx_t* dc, size_t bit_idx)
{
  return dbg_gb(dc, bit_idx);
}

size_t dbg_printf(dbg_ctx_t* dc, const char* format, ...)
{
  size_t total = 0;
  if((dc != NULL) && (format != NULL))
  {
    va_list args;
    va_start(args, format);
    total = dbg_vprintf(dc, format, args);
    va_end(args);
    return 0;
  }
  return total;
}

size_t dbg_vprintf(dbg_ctx_t* dc, const char* format, va_list args)
{
  int rv;
  size_t total = 0;
  dbg_ctx_common_t* dcc = (dbg_ctx_common_t*)dc;

  if((dcc != NULL) && (format != NULL))
  {
    char format_full[0x200];
    va_list args_copy;
    va_copy(args_copy, args);

    if(dcc->fun_name != NULL)
    {
      rv = snprintf(format_full, sizeof(format_full), "%s:%-4d %s",
        dcc->fun_name, dcc->line_num, format);
      if(rv < 0)
      {
        va_end(args_copy);
        return 0;
      }
      dcc->fun_name = NULL;
      format = format_full;
    }
    if(dcc->dbg_ctx_impl_vprintf != NULL)
    {
      dcc->dbg_ctx_impl_vprintf(dc, format, args_copy);
    }
    va_end(args_copy);
  }
  return total;
}

void dbg_assert_fail(dbg_ctx_t* dc, const char* expr,
    const char* file_name, size_t line_number, const char* func_name) {
  dbg_printf(dc, "Assert failed: %s %s:%ld %s\n", expr, file_name,
      line_number, func_name);
  exit(1);
}
