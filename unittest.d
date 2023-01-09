unittest
{
  import main;
  import core.stdc.stdio;
  import std.string;

  http_t get = http_get("http://example.com/", null, null, 0);
  if (get.is_err)
  {
    fprintf(stderr, "Error: %s", get.buffer);
  }
  else
  {
    printf(get.buffer);
  }
  
  http_t post = http_post("http://example.com/", null, null, 0, null, null, 0);
  if (post.is_err)
  {
    fprintf(stderr, "Error: %s", post.buffer);
  }
  else
  {
    printf(post.buffer);
  }
  
  http_binary_t get_binary = http_get_binary("http://example.com/", null, null, 0);
  if (get_binary.is_err)
  {
    fprintf(stderr, "Error: %s", get_binary.buffer);
  }
  else
  {
    for (size_t i = 0; i < get_binary.buffer_len; i++)
    {
      printf("%i", get_binary.buffer[i]);
    }
    printf("\n");
  }
}
