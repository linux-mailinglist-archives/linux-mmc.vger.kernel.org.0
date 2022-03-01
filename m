Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614ED4C8F5F
	for <lists+linux-mmc@lfdr.de>; Tue,  1 Mar 2022 16:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbiCAPqP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 1 Mar 2022 10:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbiCAPqO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2022 10:46:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4A14F47C;
        Tue,  1 Mar 2022 07:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646149532; x=1677685532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W8AGwJIFo3VwfaiSLF5lfqORZ0kwYB19qq5psXZTbGM=;
  b=MN3vMC2/g8I4Nk+znupjo2QlL8Ry9bRFFcgek612/kyVVKOQmtBJjlMm
   VjPw12YyA5InQMCZBl1g8LQrD0rdMVKyijfgsHFd7E3VkQWTAqt3FjCN7
   gEBz+Xt3vsSZeebo9zoCswGI2EgwtIEmjUZX35y0qAcaCuKIZVlV+i/Md
   L/vtGg/Xn7DXC/FhUTguyqNOjPZSMLN6wlY4kRG0eOMtL9tkjcpnqo+lT
   6ujQmEvXxgjR/kimidg8SzGBDcBp5Ortp2+aM4oj/5dtfY8TxbSPHhMzW
   UAVQDvzuuOK5j2XotnHFD0KjxMI8BSu4i9SKssDKFPfjjDcnXmggMT7gv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="253085157"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="253085157"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:45:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="534939253"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Mar 2022 07:45:30 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP4gr-0000dv-FL; Tue, 01 Mar 2022 15:45:29 +0000
Date:   Tue, 1 Mar 2022 23:45:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] mmc: rtsx: Fix build errors/warnings for unused variable
Message-ID: <202203012355.ehZZyZBe-lkp@intel.com>
References: <20220301115300.64332-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301115300.64332-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220228]
[cannot apply to soc/for-next linux/master linus/master v5.17-rc6 v5.17-rc5 v5.17-rc4 v5.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ulf-Hansson/mmc-rtsx-Fix-build-errors-warnings-for-unused-variable/20220301-195325
base:    6705cd745adbbeac6b13002c7a30060f7b2568a5
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220301/202203012355.ehZZyZBe-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/392366d45e7f16e01727e7e82a08085301ca3de8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ulf-Hansson/mmc-rtsx-Fix-build-errors-warnings-for-unused-variable/20220301-195325
        git checkout 392366d45e7f16e01727e7e82a08085301ca3de8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sd_request':
>> drivers/mmc/host/rtsx_pci_sdmmc.c:825:29: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
     825 |         pm_runtime_get_sync(dev);
         |                             ^~~
         |                             cdev
   drivers/mmc/host/rtsx_pci_sdmmc.c:825:29: note: each undeclared identifier is reported only once for each function it appears in
   drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_set_ios':
   drivers/mmc/host/rtsx_pci_sdmmc.c:1094:29: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
    1094 |         pm_runtime_get_sync(dev);
         |                             ^~~
         |                             cdev
   drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_get_ro':
   drivers/mmc/host/rtsx_pci_sdmmc.c:1144:29: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
    1144 |         pm_runtime_get_sync(dev);
         |                             ^~~
         |                             cdev
   drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_get_cd':
   drivers/mmc/host/rtsx_pci_sdmmc.c:1172:29: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
    1172 |         pm_runtime_get_sync(dev);
         |                             ^~~
         |                             cdev
   drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_switch_voltage':
   drivers/mmc/host/rtsx_pci_sdmmc.c:1280:29: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
    1280 |         pm_runtime_get_sync(dev);
         |                             ^~~
         |                             cdev
   drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_execute_tuning':
   drivers/mmc/host/rtsx_pci_sdmmc.c:1331:29: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
    1331 |         pm_runtime_get_sync(dev);
         |                             ^~~
         |                             cdev


vim +825 drivers/mmc/host/rtsx_pci_sdmmc.c

6291e7153a173f8 Micky Ching   2014-06-06  798  
6291e7153a173f8 Micky Ching   2014-06-06  799  static void sd_request(struct work_struct *work)
6291e7153a173f8 Micky Ching   2014-06-06  800  {
6291e7153a173f8 Micky Ching   2014-06-06  801  	struct realtek_pci_sdmmc *host = container_of(work,
6291e7153a173f8 Micky Ching   2014-06-06  802  			struct realtek_pci_sdmmc, work);
ff984e57d36e8ac Wei WANG      2012-10-29  803  	struct rtsx_pcr *pcr = host->pcr;
6291e7153a173f8 Micky Ching   2014-06-06  804  
6291e7153a173f8 Micky Ching   2014-06-06  805  	struct mmc_host *mmc = host->mmc;
6291e7153a173f8 Micky Ching   2014-06-06  806  	struct mmc_request *mrq = host->mrq;
ff984e57d36e8ac Wei WANG      2012-10-29  807  	struct mmc_command *cmd = mrq->cmd;
ff984e57d36e8ac Wei WANG      2012-10-29  808  	struct mmc_data *data = mrq->data;
6291e7153a173f8 Micky Ching   2014-06-06  809  
ff984e57d36e8ac Wei WANG      2012-10-29  810  	unsigned int data_size = 0;
c3481955f6c78c8 Wei WANG      2013-02-08  811  	int err;
ff984e57d36e8ac Wei WANG      2012-10-29  812  
b22217f966f585b Micky Ching   2015-01-14  813  	if (host->eject || !sd_get_cd_int(host)) {
ff984e57d36e8ac Wei WANG      2012-10-29  814  		cmd->error = -ENOMEDIUM;
ff984e57d36e8ac Wei WANG      2012-10-29  815  		goto finish;
ff984e57d36e8ac Wei WANG      2012-10-29  816  	}
ff984e57d36e8ac Wei WANG      2012-10-29  817  
c3481955f6c78c8 Wei WANG      2013-02-08  818  	err = rtsx_pci_card_exclusive_check(host->pcr, RTSX_SD_CARD);
c3481955f6c78c8 Wei WANG      2013-02-08  819  	if (err) {
c3481955f6c78c8 Wei WANG      2013-02-08  820  		cmd->error = err;
c3481955f6c78c8 Wei WANG      2013-02-08  821  		goto finish;
c3481955f6c78c8 Wei WANG      2013-02-08  822  	}
c3481955f6c78c8 Wei WANG      2013-02-08  823  
98fcc5762dcecbb Micky Ching   2014-04-29  824  	mutex_lock(&pcr->pcr_mutex);
7499b529d97f752 Kai-Heng Feng 2022-01-25 @825  	pm_runtime_get_sync(dev);
98fcc5762dcecbb Micky Ching   2014-04-29  826  
ff984e57d36e8ac Wei WANG      2012-10-29  827  	rtsx_pci_start_run(pcr);
ff984e57d36e8ac Wei WANG      2012-10-29  828  
ff984e57d36e8ac Wei WANG      2012-10-29  829  	rtsx_pci_switch_clock(pcr, host->clock, host->ssc_depth,
ff984e57d36e8ac Wei WANG      2012-10-29  830  			host->initial_mode, host->double_clk, host->vpclk);
ff984e57d36e8ac Wei WANG      2012-10-29  831  	rtsx_pci_write_register(pcr, CARD_SELECT, 0x07, SD_MOD_SEL);
ff984e57d36e8ac Wei WANG      2012-10-29  832  	rtsx_pci_write_register(pcr, CARD_SHARE_MODE,
ff984e57d36e8ac Wei WANG      2012-10-29  833  			CARD_SHARE_MASK, CARD_SHARE_48_SD);
ff984e57d36e8ac Wei WANG      2012-10-29  834  
98fcc5762dcecbb Micky Ching   2014-04-29  835  	mutex_lock(&host->host_mutex);
98fcc5762dcecbb Micky Ching   2014-04-29  836  	host->mrq = mrq;
98fcc5762dcecbb Micky Ching   2014-04-29  837  	mutex_unlock(&host->host_mutex);
98fcc5762dcecbb Micky Ching   2014-04-29  838  
ff984e57d36e8ac Wei WANG      2012-10-29  839  	if (mrq->data)
ff984e57d36e8ac Wei WANG      2012-10-29  840  		data_size = data->blocks * data->blksz;
ff984e57d36e8ac Wei WANG      2012-10-29  841  
1dcb35799e8fb58 Micky Ching   2014-12-23  842  	if (!data_size) {
98fcc5762dcecbb Micky Ching   2014-04-29  843  		sd_send_cmd_get_rsp(host, cmd);
1dcb35799e8fb58 Micky Ching   2014-12-23  844  	} else if (sd_rw_cmd(cmd) || sdio_extblock_cmd(cmd, data)) {
1dcb35799e8fb58 Micky Ching   2014-12-23  845  		cmd->error = sd_rw_multi(host, mrq);
6291e7153a173f8 Micky Ching   2014-06-06  846  		if (!host->using_cookie)
6291e7153a173f8 Micky Ching   2014-06-06  847  			sdmmc_post_req(host->mmc, host->mrq, 0);
98fcc5762dcecbb Micky Ching   2014-04-29  848  
98fcc5762dcecbb Micky Ching   2014-04-29  849  		if (mmc_op_multi(cmd->opcode) && mrq->stop)
98fcc5762dcecbb Micky Ching   2014-04-29  850  			sd_send_cmd_get_rsp(host, mrq->stop);
ff984e57d36e8ac Wei WANG      2012-10-29  851  	} else {
ff984e57d36e8ac Wei WANG      2012-10-29  852  		sd_normal_rw(host, mrq);
ff984e57d36e8ac Wei WANG      2012-10-29  853  	}
98fcc5762dcecbb Micky Ching   2014-04-29  854  
98fcc5762dcecbb Micky Ching   2014-04-29  855  	if (mrq->data) {
98fcc5762dcecbb Micky Ching   2014-04-29  856  		if (cmd->error || data->error)
98fcc5762dcecbb Micky Ching   2014-04-29  857  			data->bytes_xfered = 0;
98fcc5762dcecbb Micky Ching   2014-04-29  858  		else
98fcc5762dcecbb Micky Ching   2014-04-29  859  			data->bytes_xfered = data->blocks * data->blksz;
98fcc5762dcecbb Micky Ching   2014-04-29  860  	}
98fcc5762dcecbb Micky Ching   2014-04-29  861  
7499b529d97f752 Kai-Heng Feng 2022-01-25  862  	pm_runtime_mark_last_busy(dev);
7499b529d97f752 Kai-Heng Feng 2022-01-25  863  	pm_runtime_put_autosuspend(dev);
98fcc5762dcecbb Micky Ching   2014-04-29  864  	mutex_unlock(&pcr->pcr_mutex);
ff984e57d36e8ac Wei WANG      2012-10-29  865  
ff984e57d36e8ac Wei WANG      2012-10-29  866  finish:
1dcb35799e8fb58 Micky Ching   2014-12-23  867  	if (cmd->error) {
1dcb35799e8fb58 Micky Ching   2014-12-23  868  		dev_dbg(sdmmc_dev(host), "CMD %d 0x%08x error(%d)\n",
1dcb35799e8fb58 Micky Ching   2014-12-23  869  			cmd->opcode, cmd->arg, cmd->error);
1dcb35799e8fb58 Micky Ching   2014-12-23  870  	}
98fcc5762dcecbb Micky Ching   2014-04-29  871  
98fcc5762dcecbb Micky Ching   2014-04-29  872  	mutex_lock(&host->host_mutex);
98fcc5762dcecbb Micky Ching   2014-04-29  873  	host->mrq = NULL;
98fcc5762dcecbb Micky Ching   2014-04-29  874  	mutex_unlock(&host->host_mutex);
98fcc5762dcecbb Micky Ching   2014-04-29  875  
98fcc5762dcecbb Micky Ching   2014-04-29  876  	mmc_request_done(mmc, mrq);
ff984e57d36e8ac Wei WANG      2012-10-29  877  }
ff984e57d36e8ac Wei WANG      2012-10-29  878  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
