Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE899306
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Aug 2019 14:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388405AbfHVMNz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Aug 2019 08:13:55 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44019 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388399AbfHVMNw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2019 08:13:52 -0400
Received: by mail-vs1-f65.google.com with SMTP id s5so3656678vsi.10
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2019 05:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6/IjtBPVj0Oz4iJYzEDbuqonF1ZiM27DpCa69vmHwc=;
        b=Joha3CS+69v3l15rP/aCLwahlRT79HSR53vcRKRD19ch/SeKqLtDd14wSG9/aPbfRd
         l9rvapek5GoET3eH7i+sCraqajqS0AOAb/FrIkoTuWuqRXn+serk9ID311WqWdd8Bk6x
         tDXnI12KtaeMX/1o5YVOEHferPVRaYlZiyjR3iT3NmG+oV9d0BcbGbSKl2T2/JcVNOAa
         ahUcQjDD47ueJ6dTeLrwVNbO2Cb5Ch5uLv4yntlMu6llx6RUNFlnmnzvZ7J46SIsjn6Q
         y7Ar31OGKqMSh3EABmGu6BAYK29iqImtdlriR64YSTPXyfwqjiWdixjl6vTr5eJZ5/6v
         furQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6/IjtBPVj0Oz4iJYzEDbuqonF1ZiM27DpCa69vmHwc=;
        b=RYjYUQGoyd0BsTSmDUPjUZXTqrAaW/hV7wXecx3tQMOFzTPm4a5yEdOfMUpF69xIj+
         tp8CZagpXfnZB1VeIHxhV8i6nseG8CbWoFV84N8hcTzY562OpphhIlYZ1vi6Wq5Nx5IL
         CLcp0i8G7LFx21GTtF9c0ZKXNPDdrQhRxenLgCHTlyIb8yAWGLzQ2k7LpJAQfBFP6Ipl
         Td0tOeaFSdcMeOL4UslQ7zQ96rqZsYwrayxXFluhgxTl9xmpMZV2S0V8oQv0gsgDjcCB
         oXwVRuZp20DH1X/CwxX0LNZWRcaN2J37JzJ9QVqQdoe2uKNdSEbcy8w8vNg+Ups10C6c
         6BLg==
X-Gm-Message-State: APjAAAUWTvt01Ex4m1WclIW14VMzFvp5wKd+Fz7W574rd5U6WH3t9Pe1
        0n4s8Deo9eQ0bqjpjSrzw5wX0a1Y4iC4D5ST6f9yUA==
X-Google-Smtp-Source: APXvYqyhQ/ujxJj+dVFADP98FB6B+BRSrIpjyWbp9YXdhDJfkng0dqPjtRh6NyZiqzTkyemUxcsWScmqEbs0yEb9oAY=
X-Received: by 2002:a67:347:: with SMTP id 68mr18766574vsd.35.1566476031413;
 Thu, 22 Aug 2019 05:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190810121608.24145-1-paul@crapouillou.net> <20190810121608.24145-2-paul@crapouillou.net>
In-Reply-To: <20190810121608.24145-2-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 14:13:15 +0200
Message-ID: <CAPDyKFqMmCcsJi9r9j24wW9gOPsYr+t5TrryqpJ3=EH0ANwi9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: jz4740: Drop dependency on arch header
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 10 Aug 2019 at 14:16, Paul Cercueil <paul@crapouillou.net> wrote:
>
> We don't need to set the 'slave_id' anymore - that field is never read
> by the DMA driver.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 59f81e8afcce..7ff2034d739a 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -25,8 +25,6 @@
>
>  #include <asm/cacheflush.h>
>
> -#include <asm/mach-jz4740/dma.h>
> -
>  #define JZ_REG_MMC_STRPCL      0x00
>  #define JZ_REG_MMC_STATUS      0x04
>  #define JZ_REG_MMC_CLKRT       0x08
> @@ -292,11 +290,9 @@ static int jz4740_mmc_start_dma_transfer(struct jz4740_mmc_host *host,
>         if (data->flags & MMC_DATA_WRITE) {
>                 conf.direction = DMA_MEM_TO_DEV;
>                 conf.dst_addr = host->mem_res->start + JZ_REG_MMC_TXFIFO;
> -               conf.slave_id = JZ4740_DMA_TYPE_MMC_TRANSMIT;
>         } else {
>                 conf.direction = DMA_DEV_TO_MEM;
>                 conf.src_addr = host->mem_res->start + JZ_REG_MMC_RXFIFO;
> -               conf.slave_id = JZ4740_DMA_TYPE_MMC_RECEIVE;
>         }
>
>         sg_count = jz4740_mmc_prepare_dma_data(host, data, COOKIE_MAPPED);
> --
> 2.21.0.593.g511ec345e18
>
