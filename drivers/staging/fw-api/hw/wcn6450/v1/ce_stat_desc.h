
/*
 * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software for
 * any purpose with or without fee is hereby granted, provided that the
 * above copyright notice and this permission notice appear in all
 * copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 * WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 * AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 * DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 * PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 */



#ifndef _CE_STAT_DESC_H_
#define _CE_STAT_DESC_H_
#if !defined(__ASSEMBLER__)
#endif

#define NUM_OF_DWORDS_CE_STAT_DESC 4

struct ce_stat_desc {
             uint32_t ce_res_5                        :  8,
                      toeplitz_en                     :  1,
                      src_swap                        :  1,
                      dest_swap                       :  1,
                      gather                          :  1,
                      ce_res_6                        :  4,
                      length                          : 16;
             uint32_t toeplitz_hash_0                 : 32;
             uint32_t toeplitz_hash_1                 : 32;
             uint32_t fw_metadata                     : 16,
                      ce_res_7                        :  4,
                      ring_id                         :  8,
                      looping_count                   :  4;
};

#define CE_STAT_DESC_0_CE_RES_5_OFFSET                               0x00000000
#define CE_STAT_DESC_0_CE_RES_5_LSB                                  0
#define CE_STAT_DESC_0_CE_RES_5_MASK                                 0x000000ff

#define CE_STAT_DESC_0_TOEPLITZ_EN_OFFSET                            0x00000000
#define CE_STAT_DESC_0_TOEPLITZ_EN_LSB                               8
#define CE_STAT_DESC_0_TOEPLITZ_EN_MASK                              0x00000100

#define CE_STAT_DESC_0_SRC_SWAP_OFFSET                               0x00000000
#define CE_STAT_DESC_0_SRC_SWAP_LSB                                  9
#define CE_STAT_DESC_0_SRC_SWAP_MASK                                 0x00000200

#define CE_STAT_DESC_0_DEST_SWAP_OFFSET                              0x00000000
#define CE_STAT_DESC_0_DEST_SWAP_LSB                                 10
#define CE_STAT_DESC_0_DEST_SWAP_MASK                                0x00000400

#define CE_STAT_DESC_0_GATHER_OFFSET                                 0x00000000
#define CE_STAT_DESC_0_GATHER_LSB                                    11
#define CE_STAT_DESC_0_GATHER_MASK                                   0x00000800

#define CE_STAT_DESC_0_CE_RES_6_OFFSET                               0x00000000
#define CE_STAT_DESC_0_CE_RES_6_LSB                                  12
#define CE_STAT_DESC_0_CE_RES_6_MASK                                 0x0000f000

#define CE_STAT_DESC_0_LENGTH_OFFSET                                 0x00000000
#define CE_STAT_DESC_0_LENGTH_LSB                                    16
#define CE_STAT_DESC_0_LENGTH_MASK                                   0xffff0000

#define CE_STAT_DESC_1_TOEPLITZ_HASH_0_OFFSET                        0x00000004
#define CE_STAT_DESC_1_TOEPLITZ_HASH_0_LSB                           0
#define CE_STAT_DESC_1_TOEPLITZ_HASH_0_MASK                          0xffffffff

#define CE_STAT_DESC_2_TOEPLITZ_HASH_1_OFFSET                        0x00000008
#define CE_STAT_DESC_2_TOEPLITZ_HASH_1_LSB                           0
#define CE_STAT_DESC_2_TOEPLITZ_HASH_1_MASK                          0xffffffff

#define CE_STAT_DESC_3_FW_METADATA_OFFSET                            0x0000000c
#define CE_STAT_DESC_3_FW_METADATA_LSB                               0
#define CE_STAT_DESC_3_FW_METADATA_MASK                              0x0000ffff

#define CE_STAT_DESC_3_CE_RES_7_OFFSET                               0x0000000c
#define CE_STAT_DESC_3_CE_RES_7_LSB                                  16
#define CE_STAT_DESC_3_CE_RES_7_MASK                                 0x000f0000

#define CE_STAT_DESC_3_RING_ID_OFFSET                                0x0000000c
#define CE_STAT_DESC_3_RING_ID_LSB                                   20
#define CE_STAT_DESC_3_RING_ID_MASK                                  0x0ff00000

#define CE_STAT_DESC_3_LOOPING_COUNT_OFFSET                          0x0000000c
#define CE_STAT_DESC_3_LOOPING_COUNT_LSB                             28
#define CE_STAT_DESC_3_LOOPING_COUNT_MASK                            0xf0000000

#endif
