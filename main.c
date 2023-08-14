#include <stdio.h>
#include <inttypes.h>
#include "add.h"
#include "mul.h"

int main(void)
{
    printf("7 + 3 = %"PRIi32"\n", add_i32(7, 3));
    printf("7 * 3 = %"PRIi32"\n", mul(7, 3));
    return 0;
}
