Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171235937F3
	for <lists+linux-mmc@lfdr.de>; Mon, 15 Aug 2022 21:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243900AbiHOSrs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 15 Aug 2022 14:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244261AbiHOSqx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 14:46:53 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC241D21
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 11:28:26 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10cf9f5b500so9036912fac.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 11:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4BgACqig1Mi45Cs+/G7h/s0hfyaq7pp4CtuWT3zQedA=;
        b=RKQZbu7SpMqvE8sqFweu7O4+/cwvBEkat1Mvb1JDv3PnHaFXHHobLfNADPKkin/oGl
         SeFRrar+0CyylgfIi9LXMDw0frFLWjYho/RvsG1YH2ISLAA8LXzdwgo0hCz0RBecugT2
         FRTA4p46zLsDXbAidh5VLet1ValWBamov2Fspc64VAsPg19y7kU0wagtr55h4A6Fjf15
         w0jAO1bjk0FqBLRvfFe92UyF+vNz6LwN2Vl9fyCINCs1c5N824PSsKYAoklpzHXP+unf
         NZmWonsJBGtRRGdx35unuA0yp8sZggsxJHUi6CYi7+n2vorTpy81zQkUUoLGXE5tORQg
         vehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4BgACqig1Mi45Cs+/G7h/s0hfyaq7pp4CtuWT3zQedA=;
        b=szj1H8tuirs8f4g1irHUGZ67bDaleG8RzdDwkJ3iOTI20jDhtLBTXFZw3g8zhv/QSy
         e0nZM6ciCHUR4JUEp5vwXlK3HSDb+8i41kWw0Hv7IHgvEHFDsveobVY+tU8mIok2Mey7
         1rZ2Ag5j7Jt9ueQLg7Ialh0bql0whWXIRuS7xm2ycZIjWU1HpOTYRYtKfVeu/plJrMqu
         wLpg8V3bq14bqjCKJV09OZdYHQK5gKqkCDqhUS0v0sy4vW1ppUhoNK//i8e/7wp0SsSU
         MAeTUtxaxZJTZHp+SVwhCifJEk4sQ/RhlVeyWM0d7n82phT+VrmTOOeJRu7DZTPdwot6
         5Enw==
X-Gm-Message-State: ACgBeo2TNEd69v9MgXLgq1Gg4WB++uczVMfb/1+vqQLn3YXgcIJaiX7I
        1pxkBHZmCFwTVshAHWCMtvycGTAHMT/IYVYVq6eKKg==
X-Google-Smtp-Source: AA6agR4TTqNoTeU03JIaC+2g5dNCzX/cvpfy1peGRPwAdfwv5xTLb4TGuLv7e+tDPquOFps3OgV/7nglTpV8rmFJvRo=
X-Received: by 2002:a05:6870:65a7:b0:10e:d8ab:dd79 with SMTP id
 fp39-20020a05687065a700b0010ed8abdd79mr7576211oab.53.1660588106133; Mon, 15
 Aug 2022 11:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <6d75855ad4e2470e9ed99e0df21bc30f0c925a29.1658862932.git.christophe.jaillet@wanadoo.fr>
 <07a2dcebf8ede69b484103de8f9df043f158cffd.1658862932.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <07a2dcebf8ede69b484103de8f9df043f158cffd.1658862932.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 20:27:50 +0200
Message-ID: <CAPDyKFr8i1bbxoYpF7tFDMjbJzmL4ZS3v0=gVtc4enZs6S9fjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: pxamci: Fix another error handling path in pxamci_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 Jul 2022 at 21:15, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The commit in Fixes: has introduced an new error handling without branching
> to the existing error handling path.
>
> Update it now and release some resources if pxamci_init_ocr() fails.
>
> Fixes: 61951fd6cb49 ("mmc: pxamci: let mmc core handle regulators")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for fixes and by adding stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/pxamci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 37bf362a0ed5..e4003f6058eb 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -672,7 +672,7 @@ static int pxamci_probe(struct platform_device *pdev)
>
>         ret = pxamci_init_ocr(host);
>         if (ret < 0)
> -               return ret;
> +               goto out;
>
>         mmc->caps = 0;
>         host->cmdat = 0;
> --
> 2.34.1
>
