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
