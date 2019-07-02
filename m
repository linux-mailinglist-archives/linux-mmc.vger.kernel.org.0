Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53925CC72
	for <lists+linux-mmc@lfdr.de>; Tue,  2 Jul 2019 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfGBJME (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 2 Jul 2019 05:12:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:2146 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGBJME (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Jul 2019 05:12:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 02:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,442,1557212400"; 
   d="scan'208";a="171725909"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jul 2019 02:12:02 -0700
Subject: Re: [PATCH v2 1/3] mmc: add Coldfire esdhc support
To:     Angelo Dureghello <angelo@sysam.it>,
        Christoph Hellwig <hch@infradead.org>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-m68k@vger.kernel.org
References: <20190616204823.32758-1-angelo@sysam.it>
 <20190617065807.GA17948@infradead.org> <20190619222236.GA18383@jerusalem>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a5427af4-079e-7e0a-487e-389969809cb5@intel.com>
Date:   Tue, 2 Jul 2019 12:10:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619222236.GA18383@jerusalem>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/06/19 1:22 AM, Angelo Dureghello wrote:
> Hi Christoph,
> 
> On Sun, Jun 16, 2019 at 11:58:07PM -0700, Christoph Hellwig wrote:
>> On Sun, Jun 16, 2019 at 10:48:21PM +0200, Angelo Dureghello wrote:
>>> This driver has been developed as a separate module starting
>>> from the similar sdhci-esdhc-fls.c.
>>> Separation has been mainly driven from change in endianness.
>>
>> Can't we have a way to define the endianess at build or even runtime?
>> We have plenty of that elsewhere in the kernel.
> 
> well, the base sdhci layer wants to access byte-size fields of the
> esdhc controller registers.
> But this same Freescale esdhc controller may be found in 2
> flavors, big-endian or little-endian organized.
> So in this driver i am actually correcting byte-addresses to
> access the wanted byte-field in the big-endian hw controller.
> 
> So this is a bit different from a be-le endian swap of a
> long or a short that the kernel is organized to do..

Did you consider just using different sdhci_ops so that you could support
different sdhci I/O accessors?
