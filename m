Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B4F1B88F8
	for <lists+linux-mmc@lfdr.de>; Sat, 25 Apr 2020 21:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDYTar (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 25 Apr 2020 15:30:47 -0400
Received: from mout.web.de ([212.227.15.4]:46217 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgDYTar (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 25 Apr 2020 15:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587843026;
        bh=RwrA069HOzfiE5yqdsD0WFeIg6rPJQx0TsH4TCw5U9A=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=lLxRCdNmxzgg8nbSvTKagYC/6I2n1mkxn59jiYGeXwqYfOtc0kI1GkwuRPx/gGSW7
         LHTZtapiw86tHDh2Koy4ZJ6bls0WyXMk766QyTEYPYhZvTexE/UH1CmWGfmJ1uMCtl
         pL0OAqFKVZjKhwVsn8Z4ACP6pAMla2230ViMuZlU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.160.204]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mhljf-1jpKfi39DX-00Mwio; Sat, 25
 Apr 2020 21:30:25 +0200
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Kangjie Lu <kjlu@umn.edu>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yuan Zhang <yuanxzhang@fudan.edu.cn>
Subject: Re: [PATCH] mmc: owl-mmc: Fix dma_chan refcnt leak in owl_mmc_probe()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <282da79a-eda7-f534-a6ed-8ac38fcc2c8b@web.de>
Date:   Sat, 25 Apr 2020 21:30:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fB+rVVZJNRD3ane1aVJusEVoiTDTL4gCWWTmlkGc5gOFMDIwb/d
 jyMA4Jg2yiogJUGSY6Ah1XiOe1gXcXABJJbTsRQL/UXOoW4xOhM+jUkZF82QvyunQPt5HIT
 BkdchXYzKXlpCj03eKwyv8+XV9Lbcndu5LZy696IjtdevXepmWc8osEtwzkB1nVFxvhUTzt
 pWGEGeLz8QyGRbWyj66hw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C24copa4gU4=:BGU01SMQm6FRl7p4kUKNMg
 9UTb8ORH7Jvd+UHOY5zUS3RPoPNFVo8wahN6a95Lx0FT9cASiIH/zV5d/C3uRYqP2Yy3P97aL
 olYXkZllWzdobJ+GBcwoc3P4b8fRBtF68UPY6GE4lmHtefqnEiYiaN1kZTCuDyKnZMeHD7so1
 HaBix501yRO0iezCbTeoIbrGL9mfX+WLcGcFNDH2eikzTfcjkZyeWERP9Uxb+kqS/HRnecWOG
 5GfxU3Ql313Swnnf6TGVow49gUZ5DFW6lxucp92h7c8pTcv9/yW2cgaKxrtlFjDa2rUcVw5Pi
 DTqx3duFfImkbNczuZfUdUasS/IJ++YAMCilD9ZycdP+sHStnYpsIHl+Xq3T+xSasvORlLrle
 flBIeP8oqqzWY2fXraXQwHVmn9Px35bXmo5cTjQcnvlqzplUg69Cp7UQBv8eD2BXu2iZYQ5vx
 y6bYtrixMXMRIzK8rX/vr9ADX17IeSLRZdNzfz4gVX575mAoTFQLNsfVgi78TOi5I1zFYiljH
 m4vv/jvzeanm38QYvFJ18JbketMtRzhh2eocskfQ+4801yxf4Y69hdiq3cetHjp7p4ldriRry
 V3tfdB3j7wC97BKRi+uT3BXbkSutPt2KE4jGjiesgISoOy3hcJ6Zd5mIevxx+/xn4ErVuXDQX
 H9Ae502UTVcMHglzdUUAT7yi52RhdB8dNocwdJeSIOgiUz+7aya43sYauYP1by9w+sbunsAJn
 xEYWPj4qTm9uCXDBzUs1dbOhlSplMhIqA1mVEWihD4BOxX9bFRr6WJgCbRUV7gawb4GEpuM0p
 wiSnJ8EuzPVPXcSQex9tOZ2c33Zkel8bhFSok81+doe130YmRVZBbogHm/PVYJg+joVTVZjuG
 UCOXuf7+fpqYkHzremuI0MMan7p5I1GpASEGrUpctGMQNSeen9LMpAE9Ibhf6KPiQktLLhdT3
 deeUrdzuko4VmqwywJZlxIhFg28k1UbDJeHxetc97h2Vsclwv6dJwadmb6R4JL7ADMzt1Hgw1
 jYPCZX4Pfs+/nQ00C74W8jf0m9Fi1OY5cU/DeYsmfaeDreTqh5f3AS7JYXsX/IkZLnw4Wg4/7
 dN3Al6nMWJo9MasdMYutUAauwMYNyQBmbU6Jqna5y8jBgZ0wXYQC7Qfo3z7sp42RxgO+tNzYt
 cZrGDwR7BpTiWH1VbmU8arpQUvvel6Jvt9lAB4FOUi6CZu01fy6XOE+lL5K2Y1LhcDx3Cw8q0
 wppaFrAE5PCpEEZJc
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Fix this issue by jumping to "err_put_dma" label when those error
> scenarios occur.

I suggest to reconsider your jump target selection.


=E2=80=A6
> +++ b/drivers/mmc/host/owl-mmc.c
=E2=80=A6
> @@ -643,19 +643,22 @@ static int owl_mmc_probe(struct platform_device *p=
dev)
>  	return 0;
>
> +err_put_dma:
> +	if (owl_host->dma)
> +		dma_release_channel(owl_host->dma);

I interpret the source code in the way that you would like to call
this function for the desired exception handling only after a call
of the function =E2=80=9Cdma_request_chan=E2=80=9D succeeded.
Thus I would expect that the passed pointer will usually be still valid.
(Can the proposed null pointer check be omitted then?)

How do you think about the following change possibility?

+err_release_channel:
+	dma_release_channel(owl_host->dma);


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the change descri=
ption?

Regards,
Markus
