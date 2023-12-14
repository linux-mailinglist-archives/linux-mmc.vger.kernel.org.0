Return-Path: <linux-mmc+bounces-476-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6482F81324C
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Dec 2023 14:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E242824E1
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Dec 2023 13:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17785789C;
	Thu, 14 Dec 2023 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bp0wZVC4"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2681811D;
	Thu, 14 Dec 2023 05:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702562255; x=1734098255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V/bhBmq7ENpJWYEcfVMJ6z98OicWGoiGjosbM1lXL9s=;
  b=bp0wZVC45ErMtnSM2QQu8VNpQNitA8DzRs6xyEcBzReB+qlZlJFyMakJ
   OaFJG5AXhUMS+cvTp2zkLUHkY8/1ClRUq2YXyJ/WycW2lZZdo0PtQlyyw
   lSIPNwuQLHtgJQEQQbU42MAI/oyt8RpTy7wZ0lYVuNzVVzwfNycko4RJ4
   9ivZWGoTK+M8BpQ2ogqJFhGJy0MrqB+qHgsrQI4v4X8s5/y5uVQUayg3d
   s9UbUFg0S8KA308N3oCjn4cbdjjfNR4R/QagSFw4e0Eq9yhgkuXbCI9rr
   IpnaN8QoI9NBGU4n62+1Cce/JWI+JcujFASGt5dSMPZn4SYZPWZKJ39Sw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380105800"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="380105800"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 05:57:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="897753673"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="897753673"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Dec 2023 05:57:32 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDmDS-000M98-17;
	Thu, 14 Dec 2023 13:57:30 +0000
Date: Thu, 14 Dec 2023 21:57:04 +0800
From: kernel test robot <lkp@intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: oe-kbuild-all@lists.linux.dev,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-pci-gli: GL9750: Mask rootport's replay timer
 timeout during suspend
Message-ID: <202312142103.ADkXHq1r-lkp@intel.com>
References: <20231212141029.239235-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212141029.239235-1-kai.heng.feng@canonical.com>

Hi Kai-Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc5 next-20231214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kai-Heng-Feng/mmc-sdhci-pci-gli-GL9750-Mask-rootport-s-replay-timer-timeout-during-suspend/20231212-221223
base:   linus/master
patch link:    https://lore.kernel.org/r/20231212141029.239235-1-kai.heng.feng%40canonical.com
patch subject: [PATCH] mmc: sdhci-pci-gli: GL9750: Mask rootport's replay timer timeout during suspend
config: x86_64-randconfig-121-20231213 (https://download.01.org/0day-ci/archive/20231214/202312142103.ADkXHq1r-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312142103.ADkXHq1r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312142103.ADkXHq1r-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-pci-gli.c: In function 'mask_replay_timer_timeout':
>> drivers/mmc/host/sdhci-pci-gli.c:1437:33: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'ats_cap'?
    1437 |         if (!parent || !parent->aer_cap)
         |                                 ^~~~~~~
         |                                 ats_cap
   drivers/mmc/host/sdhci-pci-gli.c:1440:47: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'ats_cap'?
    1440 |         pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, &val);
         |                                               ^~~~~~~
         |                                               ats_cap
   drivers/mmc/host/sdhci-pci-gli.c:1442:48: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'ats_cap'?
    1442 |         pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, val);
         |                                                ^~~~~~~
         |                                                ats_cap
   drivers/mmc/host/sdhci-pci-gli.c: In function 'unmask_replay_timer_timeout':
   drivers/mmc/host/sdhci-pci-gli.c:1450:33: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'ats_cap'?
    1450 |         if (!parent || !parent->aer_cap)
         |                                 ^~~~~~~
         |                                 ats_cap
   drivers/mmc/host/sdhci-pci-gli.c:1453:45: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'ats_cap'?
    1453 |         pci_read_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, &val);
         |                                             ^~~~~~~
         |                                             ats_cap
   drivers/mmc/host/sdhci-pci-gli.c:1455:46: error: 'struct pci_dev' has no member named 'aer_cap'; did you mean 'ats_cap'?
    1455 |         pci_write_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, val);
         |                                              ^~~~~~~
         |                                              ats_cap


vim +1437 drivers/mmc/host/sdhci-pci-gli.c

  1431	
  1432	static void mask_replay_timer_timeout(struct pci_dev *pdev)
  1433	{
  1434		struct pci_dev *parent = pci_upstream_bridge(pdev);
  1435		u32 val;
  1436	
> 1437		if (!parent || !parent->aer_cap)
  1438			return;
  1439	
  1440		pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, &val);
  1441		val |= PCI_ERR_COR_REP_TIMER;
  1442		pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, val);
  1443	}
  1444	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

