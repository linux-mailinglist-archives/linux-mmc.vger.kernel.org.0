Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02D711E37F
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Dec 2019 13:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfLMMVI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Dec 2019 07:21:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:23203 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfLMMVI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 13 Dec 2019 07:21:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 04:21:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="265516782"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.169]) ([10.237.72.169])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2019 04:21:06 -0800
Subject: Re: [PATCH 1/2] mmc: sdhci-of-esdhc: convert to use
 esdhc_tuning_window_ptr()
To:     Yangbo Lu <yangbo.lu@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>
References: <20191212075219.48625-1-yangbo.lu@nxp.com>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3047c4ee-ad2f-f16f-a4d7-48a7bcd88ab9@intel.com>
Date:   Fri, 13 Dec 2019 14:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212075219.48625-1-yangbo.lu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Is there a fix for below coming?

	https://lore.kernel.org/lkml/8afd0f53-eba8-e000-d8cc-b464e65850c3@rasmusvillemoes.dk/

