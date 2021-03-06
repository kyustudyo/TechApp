#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "algorithm/algorithm.h"
#import "algorithm/container.h"
#import "base/internal/cycleclock.h"
#import "base/internal/low_level_scheduling.h"
#import "base/internal/per_thread_tls.h"
#import "base/internal/sysinfo.h"
#import "base/internal/tsan_mutex_interface.h"
#import "base/internal/unscaledcycleclock.h"
#import "base/internal/hide_ptr.h"
#import "base/internal/identity.h"
#import "base/internal/inline_variable.h"
#import "base/internal/scheduling_mode.h"
#import "base/internal/bits.h"
#import "base/policy_checks.h"
#import "base/const_init.h"
#import "base/port.h"
#import "base/internal/unaligned_access.h"
#import "base/internal/errno_saver.h"
#import "base/internal/exponential_biased.h"
#import "base/log_severity.h"
#import "base/internal/direct_mmap.h"
#import "base/internal/low_level_alloc.h"
#import "base/internal/pretty_function.h"
#import "base/internal/spinlock_akaros.inc"
#import "base/internal/spinlock_linux.inc"
#import "base/internal/spinlock_posix.inc"
#import "base/internal/spinlock_wait.h"
#import "base/internal/spinlock_win32.inc"
#import "base/internal/throw_delegate.h"
#import "container/internal/common.h"
#import "container/internal/hash_function_defaults.h"
#import "container/internal/hashtable_debug_hooks.h"
#import "container/internal/have_sse.h"
#import "debugging/internal/address_is_readable.h"
#import "debugging/internal/elf_mem_image.h"
#import "debugging/internal/vdso_support.h"
#import "debugging/internal/demangle.h"
#import "debugging/internal/stacktrace_arm-inl.inc"
#import "debugging/internal/stacktrace_config.h"
#import "debugging/internal/stacktrace_generic-inl.inc"
#import "debugging/internal/stacktrace_unimplemented-inl.inc"
#import "debugging/internal/stacktrace_win32-inl.inc"
#import "debugging/internal/symbolize.h"
#import "debugging/symbolize.h"
#import "debugging/symbolize_unimplemented.inc"
#import "debugging/symbolize_win32.inc"
#import "hash/internal/city.h"
#import "hash/hash.h"
#import "hash/internal/hash.h"
#import "memory/memory.h"
#import "meta/type_traits.h"
#import "numeric/int128.h"
#import "numeric/int128_have_intrinsic.inc"
#import "numeric/int128_no_intrinsic.inc"
#import "strings/internal/char_map.h"
#import "strings/internal/escaping.h"
#import "strings/internal/ostringstream.h"
#import "strings/internal/resize_uninitialized.h"
#import "strings/internal/utf8.h"
#import "strings/str_format.h"
#import "strings/internal/str_format/arg.h"
#import "strings/internal/str_format/bind.h"
#import "strings/internal/str_format/checker.h"
#import "strings/internal/str_format/extension.h"
#import "strings/internal/str_format/float_conversion.h"
#import "strings/internal/str_format/output.h"
#import "strings/internal/str_format/parser.h"
#import "strings/ascii.h"
#import "strings/charconv.h"
#import "strings/escaping.h"
#import "strings/internal/charconv_bigint.h"
#import "strings/internal/charconv_parse.h"
#import "strings/internal/memutil.h"
#import "strings/internal/stl_type_traits.h"
#import "strings/internal/str_join_internal.h"
#import "strings/internal/str_split_internal.h"
#import "strings/match.h"
#import "strings/numbers.h"
#import "strings/str_cat.h"
#import "strings/str_join.h"
#import "strings/str_replace.h"
#import "strings/str_split.h"
#import "strings/string_view.h"
#import "strings/strip.h"
#import "strings/substitute.h"
#import "synchronization/internal/graphcycles.h"
#import "synchronization/internal/kernel_timeout.h"
#import "synchronization/barrier.h"
#import "synchronization/blocking_counter.h"
#import "synchronization/internal/create_thread_identity.h"
#import "synchronization/internal/mutex_nonprod.inc"
#import "synchronization/internal/per_thread_sem.h"
#import "synchronization/internal/waiter.h"
#import "synchronization/mutex.h"
#import "synchronization/notification.h"
#import "time/internal/cctz/include/cctz/civil_time.h"
#import "time/internal/cctz/include/cctz/civil_time_detail.h"
#import "time/internal/cctz/include/cctz/time_zone.h"
#import "time/internal/cctz/include/cctz/zone_info_source.h"
#import "time/internal/cctz/src/time_zone_fixed.h"
#import "time/internal/cctz/src/time_zone_if.h"
#import "time/internal/cctz/src/time_zone_impl.h"
#import "time/internal/cctz/src/time_zone_info.h"
#import "time/internal/cctz/src/time_zone_libc.h"
#import "time/internal/cctz/src/time_zone_posix.h"
#import "time/internal/cctz/src/tzfile.h"
#import "time/civil_time.h"
#import "time/clock.h"
#import "time/internal/get_current_time_chrono.inc"
#import "time/internal/get_current_time_posix.inc"
#import "time/time.h"
#import "types/any.h"
#import "types/bad_any_cast.h"
#import "types/bad_any_cast.h"
#import "types/bad_optional_access.h"
#import "types/bad_variant_access.h"
#import "types/compare.h"
#import "types/internal/optional.h"
#import "types/optional.h"
#import "types/internal/span.h"
#import "types/span.h"
#import "types/internal/variant.h"
#import "types/variant.h"
#import "utility/utility.h"

FOUNDATION_EXPORT double abslVersionNumber;
FOUNDATION_EXPORT const unsigned char abslVersionString[];

