=begin comment

    Copyright (C) 2019 Horimoto Yasuhiro

    This file is part of Rakuroonga.

    Rakuroonga is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Rakuroong is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Rakuroonga.  If not, see <http://www.gnu.org/licenses/>.

=end comment

use NativeCall;
constant libgroonga = "groonga";

enum grn_rc (
  GRN_SUCCESS => 0,
  GRN_END_OF_DATA => 1,
  GRN_UNKNOWN_ERROR => -1,
  GRN_OPERATION_NOT_PERMITTED => -2,
  GRN_NO_SUCH_FILE_OR_DIRECTORY => -3,
  GRN_NO_SUCH_PROCESS => -4,
  GRN_INTERRUPTED_FUNCTION_CALL => -5,
  GRN_INPUT_OUTPUT_ERROR => -6,
  GRN_NO_SUCH_DEVICE_OR_ADDRESS => -7,
  GRN_ARG_LIST_TOO_LONG => -8,
  GRN_EXEC_FORMAT_ERROR => -9,
  GRN_BAD_FILE_DESCRIPTOR => -10,
  GRN_NO_CHILD_PROCESSES => -11,
  GRN_RESOURCE_TEMPORARILY_UNAVAILABLE => -12,
  GRN_NOT_ENOUGH_SPACE => -13,
  GRN_PERMISSION_DENIED => -14,
  GRN_BAD_ADDRESS => -15,
  GRN_RESOURCE_BUSY => -16,
  GRN_FILE_EXISTS => -17,
  GRN_IMPROPER_LINK => -18,
  GRN_NO_SUCH_DEVICE => -19,
  GRN_NOT_A_DIRECTORY => -20,
  GRN_IS_A_DIRECTORY => -21,
  GRN_INVALID_ARGUMENT => -22,
  GRN_TOO_MANY_OPEN_FILES_IN_SYSTEM => -23,
  GRN_TOO_MANY_OPEN_FILES => -24,
  GRN_INAPPROPRIATE_I_O_CONTROL_OPERATION => -25,
  GRN_FILE_TOO_LARGE => -26,
  GRN_NO_SPACE_LEFT_ON_DEVICE => -27,
  GRN_INVALID_SEEK => -28,
  GRN_READ_ONLY_FILE_SYSTEM => -29,
  GRN_TOO_MANY_LINKS => -30,
  GRN_BROKEN_PIPE => -31,
  GRN_DOMAIN_ERROR => -32,
  GRN_RESULT_TOO_LARGE => -33,
  GRN_RESOURCE_DEADLOCK_AVOIDED => -34,
  GRN_NO_MEMORY_AVAILABLE => -35,
  GRN_FILENAME_TOO_LONG => -36,
  GRN_NO_LOCKS_AVAILABLE => -37,
  GRN_FUNCTION_NOT_IMPLEMENTED => -38,
  GRN_DIRECTORY_NOT_EMPTY => -39,
  GRN_ILLEGAL_BYTE_SEQUENCE => -40,
  GRN_SOCKET_NOT_INITIALIZED => -41,
  GRN_OPERATION_WOULD_BLOCK => -42,
  GRN_ADDRESS_IS_NOT_AVAILABLE => -43,
  GRN_NETWORK_IS_DOWN => -44,
  GRN_NO_BUFFER => -45,
  GRN_SOCKET_IS_ALREADY_CONNECTED => -46,
  GRN_SOCKET_IS_NOT_CONNECTED => -47,
  GRN_SOCKET_IS_ALREADY_SHUTDOWNED => -48,
  GRN_OPERATION_TIMEOUT => -49,
  GRN_CONNECTION_REFUSED => -50,
  GRN_RANGE_ERROR => -51,
  GRN_TOKENIZER_ERROR => -52,
  GRN_FILE_CORRUPT => -53,
  GRN_INVALID_FORMAT => -54,
  GRN_OBJECT_CORRUPT => -55,
  GRN_TOO_MANY_SYMBOLIC_LINKS => -56,
  GRN_NOT_SOCKET => -57,
  GRN_OPERATION_NOT_SUPPORTED => -58,
  GRN_ADDRESS_IS_IN_USE => -59,
  GRN_ZLIB_ERROR => -60,
  GRN_LZ4_ERROR => -61,
  GRN_STACK_OVER_FLOW => -62,
  GRN_SYNTAX_ERROR => -63,
  GRN_RETRY_MAX => -64,
  GRN_INCOMPATIBLE_FILE_FORMAT => -65,
  GRN_UPDATE_NOT_ALLOWED => -66,
  GRN_TOO_SMALL_OFFSET => -67,
  GRN_TOO_LARGE_OFFSET => -68,
  GRN_TOO_SMALL_LIMIT => -69,
  GRN_CAS_ERROR => -70,
  GRN_UNSUPPORTED_COMMAND_VERSION => -71,
  GRN_NORMALIZER_ERROR => -72,
  GRN_TOKEN_FILTER_ERROR => -73,
  GRN_COMMAND_ERROR => -74,
  GRN_PLUGIN_ERROR => -75,
  GRN_SCORER_ERROR => -76,
  GRN_CANCEL => -77,
  GRN_WINDOW_FUNCTION_ERROR => -78,
  GRN_ZSTD_ERROR => -79
);

enum grn_encoding (
  GRN_ENC_DEFAULT => 0,
  'GRN_ENC_NONE',
  'GRN_ENC_EUC_JP',
  'GRN_ENC_UTF8',
  'GRN_ENC_SJIS',
  'GRN_ENC_LATIN1',
  'GRN_ENC_KOI8R'
);

class grn_user_data is repr('CUnion') {
  has int32 $.int_value is rw;
  has uint32 $.id is rw;
  has Pointer[void] $.ptr is rw;
}

constant GRN_CTX_MSGSIZE = 0x80;

class grn_ctx is repr('CStruct') {
  has grn_rc $.rc is rw;
  has int32 $.flags is rw;
  has grn_encoding $.encoding is rw;
  has uint8 $.ntrace is rw;
  has uint8 $.errlvl is rw;
  has uint8 $.stat is rw;
  has uint32 $.seqno is rw;
  has uint32 $.subno is rw;
  has uint32 $.seqno2 is rw;
  has uint32 $.errline is rw;
  has grn_user_data $.user_data is rw;
  has Pointer[grn_ctx] $.prev is rw;
  has Pointer[grn_ctx] $.next is rw;
  has Pointer[int8] $.errfile is readonly;
  has Pointer[int8] $.errfunc is readonly;
  has Pointer[grn_ctx_impl] $.impl is rw;
  has CArray[Pointer[void]].allocate(16) $.trace;
  has CArray[int8].allocate(GRN_CTX_MSGSIZE) $.errbuf;
};
class grn_ctx is repr('CPointer') is export { * }
class grn_obj is repr('CPointer') is export { * }

sub grn_init(--> int8) is native(libgroonga) is export { * }
sub grn_fin(--> int8)  is native(libgroonga) is export { * }

sub grn_ctx_open(int32 --> grn_ctx)
    is native(libgroonga)
    is export
    { * }
sub grn_ctx_close(grn_ctx --> int8)
    is native(libgroonga)
    is export { * }

sub grn_ctx_db(grn_ctx)
    is native(libgroonga)
    is export { * }

    is native(libgroonga)
    is export { * }
