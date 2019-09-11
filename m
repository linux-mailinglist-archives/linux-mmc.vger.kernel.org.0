Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7DAFEA3
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Sep 2019 16:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfIKOVs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 11 Sep 2019 10:21:48 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39229 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbfIKOVr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Sep 2019 10:21:47 -0400
Received: by mail-vs1-f68.google.com with SMTP id y62so13825975vsb.6
        for <linux-mmc@vger.kernel.org>; Wed, 11 Sep 2019 07:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SE8uv0620DszQIIqIp0PxyUJ6JTkZhRtluqSwePzHjw=;
        b=jbGWlG/fZofyHg1AjrnEcVtreKeWj+MwNubg9oxIHHP267Ghc0/E2+C8uMrwIl69go
         HA3HXaeo0eVPhNZw2UVhX4PHs4f5jlZsfKYEZJahGz/5VFYsXh4x17PXHguT4aS3oY5a
         6CNanWI7Z/pTfiDzXPjIQOGd9O1pXM8ijzyhMseiFhJHjuT4osQ6G2Bfv5DttnMQIPl5
         nG/ABXcryPJf3QQgxhPJbQrIDzrhgD0GuV1HqnxTArLkPKPginX4zIBOj39gEriHZnPs
         7FYMgo8Ekzg2F7rTkjR6VZ6DrJsxDtWE10i1B7+1wcU/NSt8EkkWHkCLbzAsfUUJqw9s
         FZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SE8uv0620DszQIIqIp0PxyUJ6JTkZhRtluqSwePzHjw=;
        b=mXYX3DkVO4vl6OQD3TsJvguhCV+8rqyi9FWcrgi6a+1Owr0BYmK2qaUUEUGGvgQXz4
         2Uenb9oI44ptC6Z4bmV1rHVvkXWCZjgd52eY3O2ibC18FZzoB6hhk5MeAwu5RZaZR1d3
         /TfMp8R1GTbgTU6ulo9Bqxl0C0sj6xuhBTce9u5gxT35JcFbciyBFN/qMnx6vdDD5s0F
         Hyh/JkHb/y0K//GQctepZxb76k+zzYaKBd1M7GYYKHCrfDi1KVXz7EDnPI75615x/kAk
         pmYabmGeVUsnpDSwK3Wj0HlQ3Q4MVpSIVPmO5veElNYU1L3cAvN1X5Ei5d7QLWuRobj+
         nTcg==
X-Gm-Message-State: APjAAAXv+hTqcOUfJ0oVtu9j0et2SQxWSWvOQH+TLtsTZbtpqGUwMyN9
        AiPelognEPCRVs0To6ml24ILpKbctTMMSHDdpEKSEQ==
X-Google-Smtp-Source: APXvYqxLO/N6RIaYCa3g/6C9VO4qOYNMICb4ruutrNimvJNFOZl7tnk35z7d5rSoqmOeAWgEFUSoUo4Y6m6XP29/sI4=
X-Received: by 2002:a67:983:: with SMTP id 125mr20385963vsj.191.1568211706866;
 Wed, 11 Sep 2019 07:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190906091719.24886-1-colin.king@canonical.com>
In-Reply-To: <20190906091719.24886-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Sep 2019 16:21:10 +0200
Message-ID: <CAPDyKFqriNuywSzk-c77==abgJQLWRXuKWSn_04jVy+gaB8h-Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: hi3798cv200: make array degrees static
 const, makes object smaller
To:     Colin King <colin.king@canonical.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Sep 2019 at 11:17, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate the array degrees on the stack but instead make it
> static const. Makes the object code smaller by 46 bytes.
>
> Before:
>    text    data     bss     dec     hex filename
>    5356    1560       0    6916    1b04 dw_mmc-hi3798cv200.o
>
> After:
>    text    data     bss     dec     hex filename
>    5214    1656       0    6870    1ad6 dw_mmc-hi3798cv200.o
>
> (gcc version 9.2.1, amd64)
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> index bc51cef47c47..83e1bad0a008 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> @@ -66,7 +66,7 @@ static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
>                                              u32 opcode)
>  {
> -       int degrees[] = { 0, 45, 90, 135, 180, 225, 270, 315 };
> +       static const int degrees[] = { 0, 45, 90, 135, 180, 225, 270, 315 };
>         struct dw_mci *host = slot->host;
>         struct hi3798cv200_priv *priv = host->priv;
>         int raise_point = -1, fall_point = -1;
> --
> 2.20.1
>
