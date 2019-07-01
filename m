Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A5A1B079
	for <lists+linux-mmc@lfdr.de>; Mon, 13 May 2019 08:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfEMGos (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 May 2019 02:44:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:12748 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfEMGos (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 May 2019 02:44:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 May 2019 23:44:47 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga002.jf.intel.com with ESMTP; 12 May 2019 23:44:45 -0700
Subject: Re: [RFC PATCH 2/2] mmc: sdhci: Quirk for AMD SDHC Device 0x7906
To:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Raul E Rangel <rrangel@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>
Cc:     "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Sen, Pankaj" <Pankaj.Sen@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <20190501175457.195855-2-rrangel@chromium.org>
 <08c3dc49-f5cb-401d-b900-12879f469728@intel.com>
 <495b70a3-0232-343b-9081-56869415986f@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e2341ef7-134d-7eed-bb86-e1a341ea8914@intel.com>
Date:   Mon, 13 May 2019 09:44:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <495b70a3-0232-343b-9081-56869415986f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/05/19 8:04 PM, S-k, Shyam-sundar wrote:
> On 5/2/2019 12:02 PM, Adrian Hunter wrote:
>> Cc: some AMD people
>>
>> On 1/05/19 8:54 PM, Raul E Rangel wrote:
>>> AMD SDHC 0x7906 requires a hard reset to clear all internal state.
>>> Otherwise it can get into a bad state where the DATA lines are always
>>> read as zeros.
>>>
>>> This change requires firmware that can transition the device into
>>> D3Cold for it to work correctly. If the firmware does not support
>>> transitioning to D3Cold then the power state transitions are a no-op.
>>>
>>> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> 

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
