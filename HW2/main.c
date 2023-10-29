#include <inttypes.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
// #include "clz.c"
// #include "encrypt.c"
// #include "decrypt.c"

extern uint64_t get_cycles();
extern uint64_t get_instret();
uint16_t count_leading_zeros(uint64_t x);
void decrypt(uint64_t *data, uint64_t key);
void encrypt(uint64_t *data, uint64_t key);

typedef uint64_t ticks;
static inline ticks getticks(void)
{
    uint64_t result;
    uint32_t l, h, h2;
    asm volatile(
        "rdcycleh %0\n"
        "rdcycle %1\n"
        "rdcycleh %2\n"
        "sub %0, %0, %2\n"
        "seqz %0, %0\n"
        "sub %0, zero, %0\n"
        "and %1, %1, %0\n"
        : "=r"(h), "=r"(l), "=r"(h2));
    result = (((uint64_t) h) << 32) | ((uint64_t) l);
    return result;
}



#define WORDS 12
#define ROUNDS 7

int main()
{
    ticks t0 = getticks();
    unsigned int state[WORDS] = {0};
    // measure cycles
    uint64_t instret = get_instret();
    uint64_t oldcount = get_cycles();
    

    uint64_t key = 0x0123456789ABCDEF; // Encryption key
    uint64_t test_data = 0x0000000010101010; // Test data in binary

    printf("Original Data:\n");
    printf("Data: 0x%016lx\n", test_data);

    /* Encrypt and print encrypted data */
    printf("\nEncrypted Data:\n");
    encrypt(&test_data, key);
    //test_data ^= (key << count_leading_zeros(key));
    printf("Data: 0x%016lx\n", test_data);

    /* Decrypt and print decrypted data */
    printf("\nDecrypted Data:\n");
    decrypt(&test_data, key);
    //test_data ^= (key << count_leading_zeros(key));
    printf("Data: 0x%016lx\n", test_data);
    

    uint64_t cyclecount = get_cycles() - oldcount;
    printf("cycle count: %u\n", (unsigned int) cyclecount);
    printf("instret: %x\n", (unsigned) (instret & 0xffffffff));
    //memset(state, 0, WORDS * sizeof(uint32_t));

    
    ticks t1 = getticks();
    printf("elapsed cycle: %" PRIu64 "\n", t1 - t0);
	
    return 0;
}

uint16_t count_leading_zeros(uint64_t x)
{
    x |= (x >> 1);
    x |= (x >> 2);
    x |= (x >> 4);
    x |= (x >> 8);
    x |= (x >> 16);
    x |= (x >> 32);

    x -= ((x >> 1) & 0x5555555555555555);
    x = ((x >> 2) & 0x3333333333333333) + (x & 0x3333333333333333);
    x = ((x >> 4) + x) & 0x0f0f0f0f0f0f0f0f;
    x += (x >> 8);
    x += (x >> 16);
    x += (x >> 32);

    return (64 - (x & 0x7f));
}

void decrypt(uint64_t *data, uint64_t key)
{
    uint16_t leading_zeros = count_leading_zeros(key);
    *data ^= (key << leading_zeros);
    //*data ^= (key << count_leading_zeros(key));
}

void encrypt(uint64_t *data, uint64_t key)
{
    uint16_t leading_zeros = count_leading_zeros(key);
    *data ^= (key << leading_zeros);
    //*data ^= (key << count_leading_zeros(key));
}
