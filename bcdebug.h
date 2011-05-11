
#define DBG_TODO 1
#define DBG_FIXME 2
#define DBG_WARN 4
#define DBG_LEX 8
#define DBG_YACC 16

#define TODO(fmt, arg...) if (DBG_TODO & DEBUG_MASK) printf("[TODO] "fmt"\n", ## arg)
#define FIXME(fmt, ...) if (DBG_FIXME & DEBUG_MASK) printf("[FIXME] "fmt"\n", ##__VA_ARGS__)
#define WARN(fmt, arg...) if (DBG_WARN & DEBUG_MASK) printf("[WARN] "fmt"\n", ## arg)

#define LDBG(fmt...) if (DBG_LEX & DEBUG_MASK) printf(fmt)
#define YDBG(fmt...) if (DBG_YACC & DEBUG_MASK) printf(fmt)
#define DBG(fmt, arg...) if (DEBUG_MASK) printf(fmt"\n", ## arg)

