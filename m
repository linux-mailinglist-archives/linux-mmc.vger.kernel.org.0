Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101895BFE5D
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Sep 2022 14:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiIUMvQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 21 Sep 2022 08:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiIUMuv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Sep 2022 08:50:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1959D98D0E
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 05:49:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r7so9746348wrm.2
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DkE0WAM5mBu4ol1yLPj+NtrxueZJIQFbjIxfnKHOi+c=;
        b=fkVqEcFGM0lszd7i6ZN54hIQLat5l7oCgnekCg8Mcp/xH8bm7jzzBSm/8T99t2FJpm
         UKhvOZnolU1mC8n/A6PxqziXzyL7dAJLfd5NYb3bGkMxCYDIcJCPVRl+ayHTFOWfSc8E
         ldcjbDqKIUHYfP8yaCj4r+mYgHsOBVhohcQOuJMDo04q/WBQPawhodmaZKr+uGD7df5m
         tB7bhZ5p6+nkIzqzXHMPdlS13HXKDcN/RZULhLmYtQWlEB/UXVstJrFY2X/wAhSdLKWP
         /VCUzReL1oxF3uIcnbK4JNfF2diQdvfxYI5/cZYemamcINcXuts5x2LyDZxoDJmPQdW5
         mwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DkE0WAM5mBu4ol1yLPj+NtrxueZJIQFbjIxfnKHOi+c=;
        b=Re79ERIdp64KbSNoFv5GxThz5xuAr1VT28o6kWej7Ewo7+C29CTFtHRCpXBe0pq9Gq
         xkZNFWW8SWSp2VP+z73lGJtEo7D+Zjrr2SKqriKBm3ouEPwcThPMEqFKAvnwtbYv1Pu7
         ybOTXlomrfaC3Vt1I7yv1+/4skCJRcwhfSQH4at73U3rIH5RuraCDfO/3cxCxpF3Qnoy
         wHTrCLngCPzaSEp5XuceW27Qx20iEIBqe4Cs/SKSXje6lvBWsRzG05/+/9TvfnjVdBcp
         RoPG2buYiTXJSjz9ejksMatoDrdFoNQJZ+vL4gxkM4tQXCXCPMQCUpyZ4XWe6B5JNlqh
         Eb4g==
X-Gm-Message-State: ACrzQf1BtODLM2ENCsHVxSXyme2XEJ3jAsj8ty69uTIk40QVSbesYArI
        Fo0SMVEPc16IPj+MSWKkaDFpNpOqP2nep+Xt/NePvg==
X-Google-Smtp-Source: AMsMyM5tYRcSdHsIUm8rGqjJOQIruirH3/EfGzk0TsgEMAGJo3vw/I8EmT0b8+R2yFAUfQhs7u3SxGVqCTZda41+Yeo=
X-Received: by 2002:a5d:6c6f:0:b0:22a:7778:6ea2 with SMTP id
 r15-20020a5d6c6f000000b0022a77786ea2mr17780311wrz.15.1663764549512; Wed, 21
 Sep 2022 05:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220915120923.86038-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915120923.86038-1-angelogioacchino.delregno@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Sep 2022 14:48:32 +0200
Message-ID: <CAPDyKFpQxTjFruj3Hm_xtiPTKcH9aQ=wFYvpRR2mnnqiHVGtdQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] MMC/SD support for MediaTek MT6795 Helio X10
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chaotian.jing@mediatek.com, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 15 Sept 2022 at 14:09, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This series adds support for the MMC/SD controller found on the
> MediaTek Helio X10 (MT6795).
> While at it, I've also made the compatibles and plat data ordering
> consistent.
>
> P.S.: There's no dt-bindings addition because that was already merged
>       and it's present [1] in next-20220915
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220915&id=55e7dceee83ca6584a08bd876ed0ec38de5b13ce
>
> Tested on a MT6795 Sony Xperia M5 smartphone
>
> AngeloGioacchino Del Regno (2):
>   mmc: mtk-sd: Reorder of_device_id and platform data by name
>   mmc: mtk-sd: Add support for MT6795 Helio X10
>
>  drivers/mmc/host/mtk-sd.c | 109 ++++++++++++++++++++++----------------
>  1 file changed, 62 insertions(+), 47 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
