Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461A477CB30
	for <lists+linux-mmc@lfdr.de>; Tue, 15 Aug 2023 12:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjHOKhl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 15 Aug 2023 06:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbjHOKha (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Aug 2023 06:37:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2989BB;
        Tue, 15 Aug 2023 03:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692095849; x=1723631849;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qx5tJfY1kYAR9UlQqPReIadtBhMKuSvR/hBJ0VfElWU=;
  b=iJ6DgLpPikZg7AVgN8O/WbOOxiFBnLolf6jSHSMqdkkxPuSnxJeCX6tK
   EkcJjNX4dyWXO+oxWj3MlLd45OAwARC3b+B3LCVMk5ndzgzhKVvocOsTn
   J8BYTyYcqgZHciR+PbbSCFV3WWcF4R+xlYJMNxMLO7QeJmbewweZt2hRh
   65Bt2iHFclFBzVi5bwOYRb9ufBSaYRflXNODuWccMUglCoxpSHxl7/lIi
   6o7pSiXqqO6K6lbcQvxIov/o2Jfyq4J5G8lCrg6QfRp3t1ySBdwi3lVAW
   zkvXwiUGsNvjz83nCU3mymNGW4WoUh/dPXnNG/+D/5gmb6oD14lBj7mlw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357215806"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="357215806"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 03:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="768781514"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="768781514"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.51])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 03:37:26 -0700
Message-ID: <a241ac07-c9d5-ba76-44da-267006713365@intel.com>
Date:   Tue, 15 Aug 2023 13:37:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH V2 0/2] mmc: sdhci-sprd: Add SD HS mode online tuning
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        chunyan.zhang@unisoc.com, yuelin.tang@unisoc.com
References: <20230815014057.13589-1-wenchao.chen@unisoc.com>
 <e66ee2ba-1668-cb88-f7ac-7c7722387fe7@intel.com>
 <CA+Da2qyuh-WcXdj2emkWcUkqH57W4p6aei8wijFw5fA7og0eaA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CA+Da2qyuh-WcXdj2emkWcUkqH57W4p6aei8wijFw5fA7og0eaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/08/23 13:29, Wenchao Chen wrote:
> On Tue, Aug 15, 2023 at 2:21 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 15/08/23 04:40, Wenchao Chen wrote:
>>> Change in v2:
>>> - add mmc_sd_switch() and mmc_send_status() to the header file
>>> - split up core changes from host driver changes
>>> - Use pr_debug instead of dev_info and dev_dbg
>>> - Optimize the best sampled value algorithm
>>
>> What about hooking ->set_ios() as Ulf suggested?
>>
> 
> I've tried that, but it's not a good way to do it.
> We found that sdhci_runtime_resume_host() calls ->set_ios, but we
> don't want to do that.

Given that sdhci_sprd_runtime_resume() calls sdhci_runtime_resume_host(),
it should be possible to determine when to tune, right?

> We just need SD HS mode tuning at mmc_sd_init_card().
> 
>>>
>>> Wenchao Chen (2):
>>>   mmc: core: Add host specific tuning support for SD HS mode
>>>   mmc: sdhci-sprd: Add SD HS mode online tuning
>>>
>>>  drivers/mmc/core/sd.c         |  12 +++
>>>  drivers/mmc/core/sd_ops.c     |   1 +
>>>  drivers/mmc/host/sdhci-sprd.c | 152 ++++++++++++++++++++++++++++++++++
>>>  include/linux/mmc/host.h      |   8 ++
>>>  4 files changed, 173 insertions(+)
>>>
>>

