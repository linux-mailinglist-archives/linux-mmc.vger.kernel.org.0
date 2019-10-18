Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3526FDC342
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2019 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439355AbfJRK65 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Oct 2019 06:58:57 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42619 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442496AbfJRK65 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2019 06:58:57 -0400
Received: by mail-ua1-f65.google.com with SMTP id r19so1581971uap.9
        for <linux-mmc@vger.kernel.org>; Fri, 18 Oct 2019 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tt8K7w3x8HTdPRqv2Fif3/U/rG1clDpwhUCuSLxR4V4=;
        b=ZT9bTUQ6OC5ou55VS9YQx/QBwxnwJMBR+sIN7NFLM0HxkoGrTSe8tT/Qt4JdHA2MMU
         DjId+FAIoU6fIeDoczEOErcFlOkcO+e8JNfl+TwJnF8jmbJIA+R6bZeyFK+oI6B44p93
         E2RKRQ+DqQGymqV+LjeAfkgyr/whnziPddKzcnq8Je0axdhhYXq4F8eMAkP8neG8FZxA
         Wl39/ai8CQcsHWTOzgQd5b6m4y/3Ts3GeWQSCsdZ5NjYQCswurxqeHCvmgNVCB/nNl/8
         v79pFsn/eqHdYlCzLlLczwlxIhh27cCNPny1X6S1N8A4G3XTEPqXUydW08tTHR+s/eFI
         UNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tt8K7w3x8HTdPRqv2Fif3/U/rG1clDpwhUCuSLxR4V4=;
        b=Bz1ZdJUBMVdzCHcJhAQrHHbvWJdP0XKeSDxOx6u9ZwEWWJZeaMd670R6ljBuyjdecd
         7C7dLV7+MyL/ZpzMabvcbqXi4O7GRS66oxXdeEeEL2IwNwqoqKWDFFH4sVQwFuoZXgvu
         3+re6P3agWTGpc2bP1xbsc0WCU4oolh5tDR5r9RVGwBhkw4OvfiXnqlF6h3fPzzuQh+y
         Bbj6PZ5qrJ8K7N1T38JlK/amzVUg+k/V3J9es02up/qPOka/vTG1wCSIZ0a64yUbE036
         rzdtFo//MtZgwr3RWlXdaRcX1SSmCoxPZEMUGuvHHV7q7inftTKBebL1Cny5Ipd+yoQR
         0zWA==
X-Gm-Message-State: APjAAAXlzKN8ArK63ySZDt8kNX0uEY1fCcM13BFZvW/r1rFMMimbvl1j
        wWJVnQgdVrmyIrODHL6Kai59LxblEtfpzIVMFKllrg==
X-Google-Smtp-Source: APXvYqzqXgy001fV5A91b+YnpXgC21Z0PLOBh1lckmLIHtwrkfn/IGdZxxUOfwEtNWIE5nn72WMV3aVXXjO/z8yggnw=
X-Received: by 2002:ab0:708c:: with SMTP id m12mr5080226ual.15.1571396336167;
 Fri, 18 Oct 2019 03:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191009115415.15691-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20191009115415.15691-1-ben.dooks@codethink.co.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 12:58:20 +0200
Message-ID: <CAPDyKFqGwB2uo5dVqL3nbBpch1FBO2D-TG+yXo0R0hFiCL0Tfg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: make sdmmc_idma_validate_data static
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 9 Oct 2019 at 13:54, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> Make sdmmc_idma_validate_data to avoid the following warning
> from sparse:
>
> drivers/mmc/host/mmci_stm32_sdmmc.c:28:5: warning: symbol 'sdmmc_idma_validate_data' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied for next, thanks!

Kind regards
Uffe



> ---
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 8e83ae6920ae..296be8a060a6 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -25,8 +25,8 @@ struct sdmmc_priv {
>         void *sg_cpu;
>  };
>
> -int sdmmc_idma_validate_data(struct mmci_host *host,
> -                            struct mmc_data *data)
> +static int sdmmc_idma_validate_data(struct mmci_host *host,
> +                                   struct mmc_data *data)
>  {
>         struct scatterlist *sg;
>         int i;
> --
> 2.23.0
>
