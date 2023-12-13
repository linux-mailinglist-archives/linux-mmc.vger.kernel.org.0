Return-Path: <linux-mmc+bounces-402-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3980B20A
	for <lists+linux-mmc@lfdr.de>; Sat,  9 Dec 2023 05:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BAE1C20AED
	for <lists+linux-mmc@lfdr.de>; Sat,  9 Dec 2023 04:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370BF15AB;
	Sat,  9 Dec 2023 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Th/ykdgP"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28E5193;
	Fri,  8 Dec 2023 20:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702096677; x=1733632677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8LR6YwGK/lZtidkiB9axp1TkxjdDo8IofHruUzUBFOQ=;
  b=Th/ykdgPhwGaARpA/j2Q/JxHpJZzgjeOizTqKLzhMzrgJD3mFwMR7NYm
   DhikLRAp/AAWHomvG01R9pA8WsGN9e/JN/XGtcJvTE/CLwU9HY++l1gnH
   H9tC2/9rmyKwARIkq7G4VJBtLjc5Xctx2U85g60uf8ATOSOjw6QPR5zIQ
   qqduZkKLGzLgo/rP3BbAyVIElBY1AZ+necL4fP9R3EzMOB0n8rfNyqksu
   jlZ19RXaSINOHrbmTFLcBBNx0ZjvUAL66YZTBebvlwrtuaJ736ktBf5bG
   hctfHCjaRY7Uz8AaOTktiJKjNCyvWNDpzbYG+9goIo8Wj/GHPtU/rj/IM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="397286863"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="397286863"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 20:37:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="890380587"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="890380587"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2023 20:37:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBp67-000Eov-2S;
	Sat, 09 Dec 2023 04:37:51 +0000
Date: Sat, 9 Dec 2023 12:37:31 +0800
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
Message-ID: <202312091235.tzqwgYfT-lkp@intel.com>
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
config: arc-randconfig-001-20231209 (https://download.01.org/0day-ci/archive/20231209/202312091235.tzqwgYfT-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091235.tzqwgYfT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312091235.tzqwgYfT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-brcmstb.c:237:16: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     237 |         .ops = &sdhci_brcmstb_ops_74165b0,
         |                ^


vim +/const +237 drivers/mmc/host/sdhci-brcmstb.c

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

