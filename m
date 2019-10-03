Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5DAC9C27
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Oct 2019 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfJCKYs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Oct 2019 06:24:48 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36095 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfJCKYs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2019 06:24:48 -0400
Received: by mail-vs1-f65.google.com with SMTP id v19so1335700vsv.3
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2019 03:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUPJDqzsHSNk1H5k8/Q0iBMw48zt21K630tM/GKwGDI=;
        b=UW+TPr8WxGAO56Ax+M7F2OdgUjMqPBI0s1mBOaxRM92RpEGOpAy/GKsykJWoyv9PRD
         kagndutB3vdZ51uDjUFtGyoaWU5NfdhWc3j5eyWWe1WkLHbM4F5YpTLdQZim9ZNdNrwi
         VquIkedmRDgLgS4A5nQconSXff/d8LJD5YLrvF3TGdGXc7XprutJkbNoV94ignanXwWX
         T+qlGqfw6geauNs439yahk12EBASOBQ7MSPR3Ts3OfvqKqxDc9XfbT5wM3Vsv/etUzKC
         6zV/6BUOmqR/1mZGka+YN5rJcO1S+xb/aeITYYhZjWTg4j9zIVwZjnq8IChlKCA8R0RB
         u8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUPJDqzsHSNk1H5k8/Q0iBMw48zt21K630tM/GKwGDI=;
        b=oIsD+yvXSGQIbzSBnjdsKdF2sIe8SWMTAd98FIx4VkZf0y+ZHEyMG5x7yMi8tjHQx5
         7S5LmEB8Me7ERI28CbNH3XxKr5TBLzP771j3IJ0OMOAG1sYN3YDLB4HivsnqdbhxvVHQ
         GSVl3BHYMErMzANw8pfDm9MTbf4D2zehpYBTLd+siJqjDtkMcEgjGdA46txTEGOdeo82
         hPxXcxcQaIK1+9SJcX1uR2W+1aaCJ08CE+HFr4l67ek32XCYImAiBD7esz4V2cF0c0Nq
         jq2bn+jspSferpR650VHor6sm+aktXmBEYXOfXff7gq+BvbmfTptQzmcaQ7mTrdoDmQy
         vAMQ==
X-Gm-Message-State: APjAAAXOzIFFT9nT1waEPKB08kkVyiVwvnI/MphULIOy9AishVm93ycm
        E+H42ek3xxgMiR26ERgG1nL0M03F+bSPIpsRqKv2Kg==
X-Google-Smtp-Source: APXvYqyOOISd56kBMp9zEIgY1YizQIzvRSycAqI6GLxQ3jkDBkBjNcCkRvETmgdIkDYnz55P4F9MGFzJmyFksDapan4=
X-Received: by 2002:a67:e414:: with SMTP id d20mr4584219vsf.191.1570098286207;
 Thu, 03 Oct 2019 03:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190928185107.21125-1-fontaine.fabrice@gmail.com>
In-Reply-To: <20190928185107.21125-1-fontaine.fabrice@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:24:10 +0200
Message-ID: <CAPDyKFqsFr5mtWyMDHYc88J41RDgvYsAgA_nV_uMi6TRy8NzQQ@mail.gmail.com>
Subject: Re: [PATCH] mmc_cmds.c: fix build with gcc 4.9
To:     Fabrice Fontaine <fontaine.fabrice@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Chris Ball <chris@printf.net>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Chris, Avri

On Sat, 28 Sep 2019 at 20:50, Fabrice Fontaine
<fontaine.fabrice@gmail.com> wrote:
>
> Fix following error with gcc 4.9:
>
> mmc_cmds.c:1918:9: error: missing braces around initializer [-Werror=missing-braces]
>   struct rpmb_frame frame_status = {0};
>
> Fixes:
>  - http://autobuild.buildroot.org/results/bf3b6f9f6ef39b99842b3c92495b7bf359c68158
>
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
>  mmc_cmds.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index fb37189..6b09f26 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1915,7 +1915,9 @@ static int do_rpmb_op(int fd,
>         u_int16_t rpmb_type;
>         struct mmc_ioc_multi_cmd *mioc;
>         struct mmc_ioc_cmd *ioc;
> -       struct rpmb_frame frame_status = {0};
> +       struct rpmb_frame frame_status;
> +
> +       memset(&frame_status, 0, sizeof(frame_status));
>
>         if (!frame_in || !frame_out || !out_cnt)
>                 return -EINVAL;
> --
> 2.23.0
>
