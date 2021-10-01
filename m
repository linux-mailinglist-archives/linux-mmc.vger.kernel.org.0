Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635CE41EDA9
	for <lists+linux-mmc@lfdr.de>; Fri,  1 Oct 2021 14:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhJAMl2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 1 Oct 2021 08:41:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32990 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231352AbhJAMl1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 1 Oct 2021 08:41:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633091983; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=+LA/iPiXIb7Rh6nwCE/NZX+iTrBRh1ILVRGZiiUV9tQ=; b=Fpl1A9J9FaYa+tLZttQZdK/iR0ynB5XI1SZ8Z8JG/0UQgCgkku18brOiAcsqU2HtUkJaL5SS
 ojZT3GVJoG2E3ug6y4jioRd83/LM8N/kfkvw7Ni6WNcY7onFzuolS3Tw0bkYiNSBzkPgpq9a
 P6M7IDUxt1zVhVqRnu6e8qXkdp4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 61570171a3e8d3c64013b6a2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 12:39:13
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CB7C4C43616; Fri,  1 Oct 2021 12:39:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B2F4FC4338F;
        Fri,  1 Oct 2021 12:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B2F4FC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        Pali =?utf-8?Q?Roh?= =?utf-8?Q?=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 09/24] wfx: add hwio.c/hwio.h
References: <20210920161136.2398632-1-Jerome.Pouiller@silabs.com>
        <20210920161136.2398632-10-Jerome.Pouiller@silabs.com>
        <87k0ixkr6z.fsf@codeaurora.org>
Date:   Fri, 01 Oct 2021 15:39:03 +0300
In-Reply-To: <87k0ixkr6z.fsf@codeaurora.org> (Kalle Valo's message of "Fri, 01
        Oct 2021 12:52:20 +0300")
Message-ID: <875yug6hso.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

>> --- /dev/null
>> +++ b/drivers/net/wireless/silabs/wfx/hwio.h
>> @@ -0,0 +1,79 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Low-level I/O functions.
>> + *
>> + * Copyright (c) 2017-2020, Silicon Laboratories, Inc.
>> + * Copyright (c) 2010, ST-Ericsson
>> + */
>> +#ifndef WFX_HWIO_H
>> +#define WFX_HWIO_H
>> +
>> +#include <linux/types.h>
>> +
>> +struct wfx_dev;
>> +
>> +/* Caution: in the functions below, 'buf' will used with a DMA. So, it must be
>> + * kmalloc'd (do not use stack allocated buffers). In doubt, enable
>> + * CONFIG_DEBUG_SG to detect badly located buffer.
>> + */
>> +int wfx_data_read(struct wfx_dev *wdev, void *buf, size_t buf_len);
>> +int wfx_data_write(struct wfx_dev *wdev, const void *buf, size_t buf_len);
>> +
>> +int sram_buf_read(struct wfx_dev *wdev, u32 addr, void *buf, size_t len);
>> +int sram_buf_write(struct wfx_dev *wdev, u32 addr, const void *buf, size_t len);
>> +
>> +int ahb_buf_read(struct wfx_dev *wdev, u32 addr, void *buf, size_t len);
>> +int ahb_buf_write(struct wfx_dev *wdev, u32 addr, const void *buf, size_t len);
>> +
>> +int sram_reg_read(struct wfx_dev *wdev, u32 addr, u32 *val);
>> +int sram_reg_write(struct wfx_dev *wdev, u32 addr, u32 val);
>> +
>> +int ahb_reg_read(struct wfx_dev *wdev, u32 addr, u32 *val);
>> +int ahb_reg_write(struct wfx_dev *wdev, u32 addr, u32 val);
>
> "wfx_" prefix missing from these functions.

I actually saw quite a few functions without wfx_ prefix. My preference
is that all function names would have that prefix.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
