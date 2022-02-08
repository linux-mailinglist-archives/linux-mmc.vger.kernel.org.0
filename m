Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC394AD74A
	for <lists+linux-mmc@lfdr.de>; Tue,  8 Feb 2022 12:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376427AbiBHLcY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 8 Feb 2022 06:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356755AbiBHK7D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2022 05:59:03 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75DAC03FEC5
        for <linux-mmc@vger.kernel.org>; Tue,  8 Feb 2022 02:58:58 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru BC06C211D507
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] mmc: core: use sysfs_emit() instead of sprintf()
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
References: <7e700e17-7caf-ee87-c817-9119d19a135f@omp.ru>
Organization: Open Mobile Platform
Message-ID: <3e4d800b-a607-ea22-156a-1ddcebb09a29@omp.ru>
Date:   Tue, 8 Feb 2022 13:58:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7e700e17-7caf-ee87-c817-9119d19a135f@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/7/22 10:57 PM, Sergey Shtylyov wrote:

> sprintf() (still used in the MMC core for the sysfs output) is vulnerable
> to the buffer overflow.  Use the new-fangled sysfs_emit() instead.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.
> 
>  drivers/mmc/core/bus.c      |    8 ++++----
>  drivers/mmc/core/bus.h      |    3 ++-
>  drivers/mmc/core/mmc.c      |   16 ++++++++--------
>  drivers/mmc/core/sd.c       |   22 ++++++++++------------
>  drivers/mmc/core/sdio.c     |    4 ++--
>  drivers/mmc/core/sdio_bus.c |    6 +++---
>  6 files changed, 29 insertions(+), 30 deletions(-)

[...]

   Mhm... I forgot to #include <linux/sysfs.h> in some files -- they build
without it but better safe than sorry... :-)

MBR, Sergey
