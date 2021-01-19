Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E052FBDED
	for <lists+linux-mmc@lfdr.de>; Tue, 19 Jan 2021 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbhASOsH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 19 Jan 2021 09:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389414AbhASM3E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2021 07:29:04 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B164C061573;
        Tue, 19 Jan 2021 04:27:25 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DKnvV0tDBz1s8Mv;
        Tue, 19 Jan 2021 13:26:30 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DKnvT6kxlz1qrPm;
        Tue, 19 Jan 2021 13:26:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id TG6wQP6Q9FkO; Tue, 19 Jan 2021 13:26:28 +0100 (CET)
X-Auth-Info: gfwXCj6ioGLcMlG5xwuDcWczg+YKs/KDYJt3xm6T8Gw=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 19 Jan 2021 13:26:28 +0100 (CET)
Subject: Re: [PATCH v3] mmc: mmci: Convert bindings to DT schema
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org
References: <20210119100655.2755164-1-linus.walleij@linaro.org>
From:   Marek Vasut <marex@denx.de>
Message-ID: <5e2d5f9c-15f9-248a-9ef2-335ad0118e2b@denx.de>
Date:   Tue, 19 Jan 2021 13:26:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210119100655.2755164-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/19/21 11:06 AM, Linus Walleij wrote:
> This converts the MMCI bindings from simple text to a proper
> schema.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Marek Vasut <marex@denx.de>

Thanks
