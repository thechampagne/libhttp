import std;
import std.string;
import core.stdc.stdlib;
import core.stdc.string;
import arsd.http;

struct http_t
{
  int is_err;
  char* buffer;
}

struct http_binary_t
{
  int is_err;
  size_t buffer_len;
  ubyte* buffer;
}

extern(C) http_t http_get(const char* url,
			  const char** cookies_keys,
			  const char** cookies_values,
			  size_t cookies_len)
{
  string[string] cookies;
  if (cookies_keys == null || cookies_values == null)
  {
    cookies = null;
  }
  else
  {
    for (size_t i = 0; i < cookies_len; i++)
    {
      cookies[cookies_keys[i].fromStringz.idup] = cookies_values[i].fromStringz.idup;
    }
  }
  http_t http;
  try
  {
    auto str = get(url.fromStringz.idup, cookies);
    auto res = cast(char*) malloc(char.sizeof * str.length + 1);
    strcpy(res, str.toStringz);
    http.buffer = res;
    http.is_err = 0;
    return http;
  }
  catch(Exception ex)
  {
    auto res = cast(char*) malloc(char.sizeof * ex.msg.length + 1);
    strcpy(res, ex.msg.toStringz);
    http.buffer = res;
    http.is_err = 1;
    return http;
  }
}

extern(C) http_t http_post(const char* url,
			   const char**  args_keys,
			   const char**  args_values,
			   size_t args_len,
			   const char** cookies_keys,
			   const char** cookies_values,
			   size_t cookies_len)
{
  string[string] cookies;
  string[string] args;

  if (args_keys == null || args_values == null)
  {
    args = null;
  }
  else
  {
    for (size_t i = 0; i < args_len; i++)
    {
      args[args_keys[i].fromStringz.idup] = args_values[i].fromStringz.idup;
    }
  }
  if (cookies_keys == null || cookies_values == null)
  {
    cookies = null;
  }
  else
  {
    for (size_t i = 0; i < cookies_len; i++)
    {
      cookies[cookies_keys[i].fromStringz.idup] = cookies_values[i].fromStringz.idup;
    }
  }
  http_t http;
  try
  {
    auto str = post(url.fromStringz.idup, args,cookies);
    auto res = cast(char*) malloc(char.sizeof * str.length + 1);
    strcpy(res, str.toStringz);
    http.buffer = res;
    http.is_err = 0;
    return http;
  }
  catch(Exception ex)
  {
    auto res = cast(char*) malloc(char.sizeof * ex.msg.length + 1);
    strcpy(res, ex.msg.toStringz);
    http.buffer = res;
    http.is_err = 1;
    return http;
  }  
}

extern(C) http_binary_t http_get_binary(const char* url,
				  const char** cookies_keys,
				  const char** cookies_values,
				  size_t cookies_len)
{
  string[string] cookies;
  if (cookies_keys == null || cookies_values == null)
  {
    cookies = null;
  }
  else
  {
    for (size_t i = 0; i < cookies_len; i++)
    {
      cookies[cookies_keys[i].fromStringz.idup] = cookies_values[i].fromStringz.idup;
    }
  }
  http_binary_t http;
  try
  {
    auto bin = getBinary(url.fromStringz.idup, cookies);
    auto res = cast(ubyte*) malloc(ubyte.sizeof * bin.length);
    memcpy(res, cast(void*) bin, bin.length);
    http.buffer = res;
    http.buffer_len = bin.length;
    http.is_err = 0;
    return http;
  }
  catch(Exception ex)
  {
    auto res = cast(ubyte*) malloc(ubyte.sizeof * ex.msg.length + 1);
    memcpy(res, ex.msg.toStringz, ex.msg.length);
    res[ex.msg.length] = '\0';
    http.buffer = res;
    http.buffer_len = ex.msg.length;
    http.is_err = 1;
    return http;
  }
}
