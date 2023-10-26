Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A877D7D7E97
	for <lists+linux-mmc@lfdr.de>; Thu, 26 Oct 2023 10:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjJZIik (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 26 Oct 2023 04:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZIik (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Oct 2023 04:38:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CE0129
        for <linux-mmc@vger.kernel.org>; Thu, 26 Oct 2023 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698309518; x=1729845518;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A/qOiTWPJYt7AozfwBC0SBDs3VavhOHRW2IeolG9Xsc=;
  b=eZxb1pNtgJLj74aJUAm9MFVlnW0c/Wfqg8DHZqva1ixjkar/4yYVdBwe
   BVxqqJfN4bJW9jKUx1vLsILyFgZpOrNlCisthJBVQaJ3UcGQq0wQ80ZgA
   tuvsiPMhikE+BDZYvNgXsParYTKHW9IJi3IjT77lMZzVYYFPyGCJ8AbWq
   rQ2aan+soyIQoG/xgO7x//jn9dlSvkqQX4nmiiZnHY8kBBjD5hC2umxLD
   l8G/sTzW8QgvwdDs2Nwu8Om8UX9+k0T7CYAQwQrAfvgCQt5kdJvnzs4KE
   L0E4eeQ1T3S6PgKqIIWzKBrpEQMHMZexyc0Zoar/S1w25oQcOH7MwIzsa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="387316228"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="387316228"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 01:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="752640993"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="752640993"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.211.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 01:38:36 -0700
Message-ID: <afdada50-cdcb-4edb-a026-c872e1914e43@intel.com>
Date:   Thu, 26 Oct 2023 11:38:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] mmc: host: Disable auto-cmd12 during ffu
Content-Language: en-US
To:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
References: <20231025113035.1881418-1-avri.altman@wdc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231025113035.1881418-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/10/23 14:30, Avri Altman wrote:
> Field Firmware Update (ffu) may use close-ended or open ended sequence.
> Each such sequence is comprised of a write commands enclosed between 2
> switch commands - to and from ffu mode.
> 
> Some platforms generate auto command error interrupt when it shouldn't,
> e.g. auto-cmd12 while in close-ended ffu sequence.  I encountered  this
> issue while testing fwupd (github.com/fwupd/fwupd) on HP Chromebook x2,
> a qualcomm based QC-7c, code name - strongbad. Instead of a quirk, make
> sure it disable auto-cmd12 while close-ended ffu is in progress.

I think I misunderstood this because I was thinking that auto-cmd12
was being used with an open-ended sequence, and that it wasn't
working with FFU.  However it seems mmc-utils is using a closed-ended
sequence.

It looks like the the host controller driver doesn't know that,
because the ioctl interface does not use mrq.sbc and the
SET_BLOCK_COUNT command is sent separately.  Then when the MULTI_WRITE
command is issued, the host controller driver treats it as open-ended
and will enable auto-cmd12 if the controller supports it.

If that is the case, it would be better to fix the ioctl handling
and make it use mrq.sbc instead of issuing SET_BLOCK_COUNT separately.

> 
> v2 -> v3:
>  - fix an issue Reported-by: kernel test robot <lkp@intel.com>
> 
> v1->v2:
>  - Attend Adrian's suggestions
> 
> Avri Altman (2):
>   mmc: core: Mark close-ended ffu in progress
>   mmc: host: msm: Disable auto-cmd12 during ffu
> 
>  drivers/mmc/core/block.c     | 34 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-msm.c | 24 ++++++++++++++++++++++++
>  include/linux/mmc/host.h     |  1 +
>  include/linux/mmc/mmc.h      |  1 +
>  4 files changed, 60 insertions(+)
> 

