Return-Path: <linux-mmc+bounces-405-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC0E80B405
	for <lists+linux-mmc@lfdr.de>; Sat,  9 Dec 2023 12:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0108CB20AE0
	for <lists+linux-mmc@lfdr.de>; Sat,  9 Dec 2023 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD3B13FFD;
	Sat,  9 Dec 2023 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOvxDmS3"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518CC10E0;
	Sat,  9 Dec 2023 03:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702121778; x=1733657778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6H4hUz1uOtUuFXAePyGh3wdpMDe//yvf1mPaHfsj9Aw=;
  b=GOvxDmS32t3lOoGVON5CjX5fmS1KQkIEafc50Mwy58HlcZ6BHRjn9/qc
   m2uXs1YPwGVzqHJCXJJ6toVkTqfMTkKtQDA/29JcSuBzZxzVALOtazNFh
   a68h8gj6F1cZFfhpZyqq4kKc5dsBAqsJqIwyWQA34wVhqCf98ylAjps1D
   u05FUAKxuTrRJrdqpdHxE0ngev09gYktRR7Ke6hG8M1siYKgffGfxyOaQ
   8yAzIUXwjjZXsmFRQSR5HHPfS/dLcI4KTcXcsGRiC3VTMDC0QR1IBikUM
   toSqUI2yDaQ5BsxzAn4t5vMa7CRBYYmnmrijSkfVfksTXztHLCoTV+EDF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="425638006"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="425638006"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 03:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1103855927"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="1103855927"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Dec 2023 03:36:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBvcy-000FI4-1K;
	Sat, 09 Dec 2023 11:36:12 +0000
Date: Sat, 9 Dec 2023 19:35:40 +0800
From: kernel test robot <lkp@intel.com>
To: Kamal Dasu <kamal.dasu@broadcom.com>, ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org, alcooperx@gmail.com,
	linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, f.fainelli@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	Kamal Dasu <kdasu@broadcom.com>
Subject: Re: [PATCH 2/2] mmc: add new sdhci reset sequence for brcm 74165b0
Message-ID: <202312091905.UGzltx8A-lkp@intel.com>
References: <20231208202108.7468-2-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208202108.7468-2-kamal.dasu@broadcom.com>

Hi Kamal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on soc/for-next linus/master v6.7-rc4 next-20231208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamal-Dasu/mmc-add-new-sdhci-reset-sequence-for-brcm-74165b0/20231209-042222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231208202108.7468-2-kamal.dasu%40broadcom.com
patch subject: [PATCH 2/2] mmc: add new sdhci reset sequence for brcm 74165b0
config: nios2-randconfig-r133-20231209 (https://download.01.org/0day-ci/archive/20231209/202312091905.UGzltx8A-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231209/202312091905.UGzltx8A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312091905.UGzltx8A-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mmc/host/sdhci-brcmstb.c:237:17: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected struct sdhci_ops *ops @@     got struct sdhci_ops const * @@
   drivers/mmc/host/sdhci-brcmstb.c:237:17: sparse:     expected struct sdhci_ops *ops
   drivers/mmc/host/sdhci-brcmstb.c:237:17: sparse:     got struct sdhci_ops const *

vim +237 drivers/mmc/host/sdhci-brcmstb.c

   233	
   234	static const struct brcmstb_match_priv match_priv_74165b0 = {
   235		.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
   236		.hs400es = sdhci_brcmstb_hs400es,
 > 237		.ops = &sdhci_brcmstb_ops_74165b0,
   238	};
   239	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

