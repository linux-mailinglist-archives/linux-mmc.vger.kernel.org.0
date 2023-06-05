Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65854722144
	for <lists+linux-mmc@lfdr.de>; Mon,  5 Jun 2023 10:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjFEIoA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 5 Jun 2023 04:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFEIn7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2023 04:43:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDAAC7;
        Mon,  5 Jun 2023 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685954638; x=1717490638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9MY3WW6CqLpJTMPf39zMocMMeYKlKyXJGNQjClqE0hA=;
  b=VxDpYgC3/+iFw++CxM8R8TYtTnBXZAR49flPH6bCMf0oPuW9cITIAyoh
   4utrBXnZWH1jygb1ADtNlJBpJOqWeQJMYZA+TpUc0vIbGQRaMi6hfJFqL
   MrK//CjtoqTb1Umeq2Of956cttKrRh9u00jY+r/Hz9H4ERDy6PtVlAoD/
   o9m1gWPhZxGGG3/HlwQKiRdWBhdWCSeRc55b2o6ba51rIRh6yKqvgVXPX
   S+YirKenOGJN1m112I8PcdHbGWC4/aS8CrpqGYnUISahSQtbm5IODaAwb
   IhYRyHxMNyrcs2wQi3InweE4eyysuNgK1jm2KgMTBCWlQ1+oe6MXn1+eZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="356327456"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="356327456"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 01:43:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="798340339"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="798340339"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jun 2023 01:43:54 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q65of-00042D-2E;
        Mon, 05 Jun 2023 08:43:53 +0000
Date:   Mon, 5 Jun 2023 16:43:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: Re: [PATCH v3] mmc: mtk-sd: reduce CIT for better performance
Message-ID: <202306051648.vkycL2Do-lkp@intel.com>
References: <20230605060107.22044-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605060107.22044-1-wenbin.mei@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wenbin,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on ulf-hansson-mmc-mirror/next v6.4-rc5 next-20230605]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenbin-Mei/mmc-mtk-sd-reduce-CIT-for-better-performance/20230605-140238
base:   linus/master
patch link:    https://lore.kernel.org/r/20230605060107.22044-1-wenbin.mei%40mediatek.com
patch subject: [PATCH v3] mmc: mtk-sd: reduce CIT for better performance
config: powerpc-buildonly-randconfig-r006-20230605 (https://download.01.org/0day-ci/archive/20230605/202306051648.vkycL2Do-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/225e46f420d48f7ad73253636a0553bd5f986435
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wenbin-Mei/mmc-mtk-sd-reduce-CIT-for-better-performance/20230605-140238
        git checkout 225e46f420d48f7ad73253636a0553bd5f986435
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306051648.vkycL2Do-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./arch/powerpc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/mmc/host/mtk-sd.c:7:
   drivers/mmc/host/mtk-sd.c: In function 'msdc_cqe_cit_cal':
   include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   drivers/mmc/host/mtk-sd.c:2470:25: note: in expansion of macro 'do_div'
    2470 |                         do_div(hclk_freq, 1000);
         |                         ^~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12:
   include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   drivers/mmc/host/mtk-sd.c:2470:25: note: in expansion of macro 'do_div'
    2470 |                         do_div(hclk_freq, 1000);
         |                         ^~~~~~
   include/asm-generic/div64.h:238:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
         |                                    |
         |                                    u32 * {aka unsigned int *}
   drivers/mmc/host/mtk-sd.c:2470:25: note: in expansion of macro 'do_div'
    2470 |                         do_div(hclk_freq, 1000);
         |                         ^~~~~~
   include/asm-generic/div64.h:213:38: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'u32 *' {aka 'unsigned int *'}
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                            ~~~~~~~~~~^~~~~~~~
   include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   drivers/mmc/host/mtk-sd.c:2473:25: note: in expansion of macro 'do_div'
    2473 |                         do_div(hclk_freq, 100);
         |                         ^~~~~~
   include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   drivers/mmc/host/mtk-sd.c:2473:25: note: in expansion of macro 'do_div'
    2473 |                         do_div(hclk_freq, 100);
         |                         ^~~~~~
   include/asm-generic/div64.h:238:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
         |                                    |
         |                                    u32 * {aka unsigned int *}
   drivers/mmc/host/mtk-sd.c:2473:25: note: in expansion of macro 'do_div'
    2473 |                         do_div(hclk_freq, 100);
         |                         ^~~~~~
   include/asm-generic/div64.h:213:38: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'u32 *' {aka 'unsigned int *'}
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                            ~~~~~~~~~~^~~~~~~~
   include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   drivers/mmc/host/mtk-sd.c:2476:25: note: in expansion of macro 'do_div'
    2476 |                         do_div(hclk_freq, 10);
         |                         ^~~~~~
   include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   drivers/mmc/host/mtk-sd.c:2476:25: note: in expansion of macro 'do_div'
    2476 |                         do_div(hclk_freq, 10);
         |                         ^~~~~~
   include/asm-generic/div64.h:238:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
         |                                    |
         |                                    u32 * {aka unsigned int *}
   drivers/mmc/host/mtk-sd.c:2476:25: note: in expansion of macro 'do_div'
    2476 |                         do_div(hclk_freq, 10);
         |                         ^~~~~~
   include/asm-generic/div64.h:213:38: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'u32 *' {aka 'unsigned int *'}
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                            ~~~~~~~~~~^~~~~~~~
>> drivers/mmc/host/mtk-sd.c:2489:11: error: expected '}' before 'else'
    2489 |         } else {
         |           ^~~~
   cc1: some warnings being treated as errors


vim +2489 drivers/mmc/host/mtk-sd.c

  2453	
  2454	static void msdc_cqe_cit_cal(struct msdc_host *host, u64 timer_ns)
  2455	{
  2456		struct mmc_host *mmc = mmc_from_priv(host);
  2457		struct cqhci_host *cq_host = mmc->cqe_private;
  2458		u8 itcfmul;
  2459		u32 hclk_freq;
  2460		u64 value;
  2461	
  2462		/* Since MSDC CQE uses msdc_hclk as ITCFVAL, so driver should use hclk
  2463		 * frequency to get the actual time for CIT.
  2464		 */
  2465		if (host->h_clk) {
  2466			hclk_freq = clk_get_rate(host->h_clk);
  2467			itcfmul = CQHCI_CAP_ITCFMUL(cqhci_readl(cq_host, CQHCI_CAP));
  2468			switch (itcfmul) {
  2469			case 0x0:
  2470				do_div(hclk_freq, 1000);
  2471				break;
  2472			case 0x1:
  2473				do_div(hclk_freq, 100);
  2474				break;
  2475			case 0x2:
  2476				do_div(hclk_freq, 10);
  2477				break;
  2478			case 0x3:
  2479				break;
  2480			case 0x4:
  2481				hclk_freq = hclk_freq * 10;
  2482				break;
  2483			default:
  2484				host->cq_ssc1_time = 0x40;
  2485				return;
  2486			value = hclk_freq * timer_ns;
  2487			do_div(value, 1000000000ULL);
  2488			host->cq_ssc1_time = value;
> 2489		} else {
  2490			host->cq_ssc1_time = 0x40;
  2491		}
  2492	}
  2493	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
