Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9446F44BA58
	for <lists+linux-mmc@lfdr.de>; Wed, 10 Nov 2021 03:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhKJCgN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 9 Nov 2021 21:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhKJCgM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 21:36:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1405CC061764;
        Tue,  9 Nov 2021 18:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=vaMquRSSr3aFa23drkfuWw9iKepZuzFpwndhUSYbvRQ=; b=1goCbOPQEKW0bXEYR63uiqnNqR
        E/LwK+maT7sKLA6Kv/7JPMbQDpfHtaMWPIfk5/H0ka+DFU5EbhoMU4Y5i4+WFfazUE9zWOOT7s5d6
        2htpB+yfojgD5V174QRt1byC53pjXio9RmJAAbrNBR7+JDf2Ml9wnV+36ty/xnt70gg9RoD0E5OEG
        QZYcVcDf2pTA9d6QGWXDnrF57BXsVpr65MbYViE6mOP7UWizl+C6mkLMPFk+aH4OQFvUEL0Ax2gKp
        WBF6hjn8FkqLsqj08exjt136gkFyB4ZvfGVapAcY/s05KDvxfzUpGXPzbQgkhpiZgH+yD3YhQ40J0
        LUyc2nVw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkdQF-008qUm-In; Wed, 10 Nov 2021 02:33:12 +0000
Subject: Re: [PATCH v2 1/2] mmc: Add SD/SDIO driver for Sunplus SP7021
To:     "LH.Kuo" <lhjeff911@gmail.com>, p.zabel@pengutronix.de,
        daniel.thompson@linaro.org, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, ulf.hansson@linaro.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
References: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
 <1636444705-17883-1-git-send-email-lh.kuo@sunplus.com>
 <1636444705-17883-2-git-send-email-lh.kuo@sunplus.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6c5c6e83-8176-8b4a-9c2c-f01a262de5de@infradead.org>
Date:   Tue, 9 Nov 2021 18:33:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1636444705-17883-2-git-send-email-lh.kuo@sunplus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi--

On 11/8/21 11:58 PM, LH.Kuo wrote:
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5af8494..2aba9eb 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1091,5 +1091,15 @@ config MMC_OWL
>   	  This selects support for the SD/MMC Host Controller on
>   	  Actions Semi Owl SoCs.
>   
> +config MMC_SP_SDV2
> +	tristate "Sunplus SP7021 SD/SDIO Controller"
> +	depends on SOC_SP7021
> +	help
> +		If you say yes here, you will get support for SD/SDIO host interface
> +		on sunplus Socs.

		   Sunplus SoCs.

> +		If you have a controller with this interface, say Y or M here.
> +		If unsure, say N.

All 4 lines of help text should be indented only with one tab + 2 spaces,
not 2 tabs, per coding-style.rst.


> +                Sunplus  SD/SDIO Host Controller support"

I am thinking that this last line should not be here at all... ???


thanks.
-- 
~Randy
