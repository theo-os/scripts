#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <sys/mount.h>
#include <unistd.h>

int mountfs(char *src, char *target, char *type, int flags, char *opts) {
  int result = mount(src, target, type, flags, opts);

  if (result == 0) {
    printf("Mount created at %s...\n", target);
  } else {
    printf("Error : Failed to mount %s\n"
           "Reason: %s [%d]\n",
           src, strerror(errno), errno);
    return -1;
  }

  return 0;
}

int main() {
  int res = mountfs("proc", "/proc", "proc", 0, "");
  if (res != 0)
    return res;

  char *args[] = {"nu", NULL};
  char *env[] = {NULL};
  return execve("/bin/nu", args, env);
}
