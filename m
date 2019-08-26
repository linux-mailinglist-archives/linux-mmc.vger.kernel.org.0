Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42FB39DA0F
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 01:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfHZXlO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 26 Aug 2019 19:41:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42583 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbfHZXlO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Aug 2019 19:41:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BC21320F5C;
        Mon, 26 Aug 2019 19:41:10 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 26 Aug 2019 19:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=b6gK9Z0HBCIrzjuVL3PtgdZDNROaOQs
        GEZzEggIRfVE=; b=cQqchq0ozGW0puceRe7q9wyVlMbfVN2H+TSD66CiOi7utLk
        7NitNr1kiS6uuRkPfEwPrUgj2Y3B4SNBeKaQUwUBRx//DehErGWC2CS1KRUa8rpG
        lV5UuR4ZObgeYC20Ijbn7C1uxAxv31dD/pIl2+w7/ogpa3N1O07r3JGrWNpOKX0l
        wkU6ILc5I3mCilwsn+9C23OEIbEG/ZxdE+ptNR+F2qgN7Oi5cjXsE+g8HeiPJiD8
        OMNoZByDAKiZF5cANroqhiQSCJYVqsqMQA5SoOU2DJRx08qTDw3FPh2t65xgh1e9
        fSnE5O2Dq3pBW/3HFux71yadgAmhivOUgYge1Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=b6gK9Z
        0HBCIrzjuVL3PtgdZDNROaOQsGEZzEggIRfVE=; b=IdCtWamyrlUuRijPg3dExw
        WnKjrXYjEt1zYLN4MyAIdDcJrZW7z0MZZddYwJjT+AtQ7w4ysurVaX5fwKpwdlRx
        LyrydUkHxRZWsurCJuKwyt9xZx+rv6wENQ7r5wOV8ih5buRpPJPxAlYRmFmmz+wu
        HoZJtYUSA9sl2kWecaOjcLqDvqV8LCTWC3Rb2HeBEi4DDx7A1SlQ1ephRqj7lPDA
        EsSkce2LiHYErWkOnWlfxCXsFV4WCVEFqyDYSuPBieyO3RlqzV7nONp/ETj58ZbS
        8LZCUH0iLfa7zWiQoXqq9+NtAFhUAfyKMxjmO8T+yYixmQL2ibkGquQ8+KOAFguQ
        ==
X-ME-Sender: <xms:FW5kXWqZeLZ3N9nOExpzv1HyQalR89DNl0zMPCF5mdCpldGueVTLTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehhedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:FW5kXUVjbpswDRQyx4ktX97fB8NTndYQnvhSJhH5lc09OsfXmD5utg>
    <xmx:FW5kXWCIpgdbS1DYVzJJ2m0UypAAXXyecHKEtAzT1XVHjx1DIExWfQ>
    <xmx:FW5kXYUMP_dLuKeXT6Ld14yCOrsbFeYKspCwqkR0wnU5UD28cKXJKg>
    <xmx:Fm5kXWIkRy4USgX5OrGvI47HsHeE14uSKVtv-C2VMMMU7qsE1yxxdg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3F0F8E00A3; Mon, 26 Aug 2019 19:41:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-916-g49fca03-fmstable-20190821v7
Mime-Version: 1.0
Message-Id: <e23e0193-51c8-41a2-95f7-d48f0ef00eb5@www.fastmail.com>
In-Reply-To: <20190826120013.183435-1-weiyongjun1@huawei.com>
References: <20190826120013.183435-1-weiyongjun1@huawei.com>
Date:   Tue, 27 Aug 2019 09:10:37 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Wei Yongjun" <weiyongjun1@huawei.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: =?UTF-8?Q?Re:_[PATCH_-next]_mmc:_aspeed:_Fix_return_value_check_in_aspee?=
 =?UTF-8?Q?d=5Fsdc=5Fprobe()?=
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Mon, 26 Aug 2019, at 21:27, Wei Yongjun wrote:
> In case of error, the function of_platform_device_create() returns
> NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
> check should be replaced with NULL test.
> 
> Fixes: 09eed7fffd33 ("mmc: Add support for the ASPEED SD controller")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c 
> b/drivers/mmc/host/sdhci-of-aspeed.c
> index 8bb095ca2fa9..d5acb5afc50f 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -261,9 +261,9 @@ static int aspeed_sdc_probe(struct platform_device 
> *pdev)
>  		struct platform_device *cpdev;
>  
>  		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
> -		if (IS_ERR(cpdev)) {
> +		if (!cpdev) {
>  			of_node_put(child);
> -			ret = PTR_ERR(cpdev);
> +			ret = -ENODEV;
>  			goto err_clk;
>  		}
>  	}

I ... have no idea why I wrote it that way. I must have just assumed it returned
an ERR_PTR(). Thanks for finding/fixing that.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
