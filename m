Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9EA9930B
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Aug 2019 14:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbfHVMOE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Aug 2019 08:14:04 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:45357 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388411AbfHVMN7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2019 08:13:59 -0400
Received: by mail-ua1-f51.google.com with SMTP id w7so1893670uao.12
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2019 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoBmeUN23M8f6sfbc9hjllfgwqRgBk2+sJFpDr9LHV0=;
        b=fBVXvdd5bwH+sPQ0EwczYi7R6UmwhFeLh0tBrRFjzXX7IFfV2KnWfv8vwWiNuIBB8H
         NGGZv62Zk/qT4ZXkyI0BBvAYEl+xvjQK7SG7Tsj0MijJuSmyal+GioBCqP3LfHzD4+oY
         H4u7Wfgxm/ojS3Txbnuys36cWl+exdG4o4s0mesYIrVTF2ehlmDXzZqXpQFcEd+LatFA
         1zFeZZ+yHi8H7Dy4+/zq0XzTxf0XkUSK77ho1+CZNnHkMvgw6bTJmR1mvUE0A01KmHn2
         MdqHGzSDf7tD3eCbDAEt80tOupjxhBET+sk/uQ0Xjzk1P95B6OphlIfJrhjJs6r2lq83
         HQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoBmeUN23M8f6sfbc9hjllfgwqRgBk2+sJFpDr9LHV0=;
        b=tZNAEBspZeHMJrq0+Q7Z0R92rf4FhJYU/NshyrqXrJ7PkzaC00dPV4jkzISRvhJz2t
         +ou4ab7ThEJ6OFp60yYLMxnATzCOJHyPC9Mb4m4Nq/14SVDBLmKRwPzylEXLHxaZusyu
         SNTOI3X2sAbYHSYpZiHVchlGFwegXHY90EqMre2mzPyvz/ru/L7mjqVS5wJvxhkGJ0AL
         2vDMH86+gRdAqTVZx/VCrc9Kekprem0SD/u1gM4tKMqgl0ZbKtEHBYQWtCugdPhWgyFu
         6ckWUm1eyYV9n5qXZC427RN3ONfozKpI0eZDcXT5IfUf8zBzW5DWm+S3MNWjUtPHxtYa
         +n8A==
X-Gm-Message-State: APjAAAVR9LhMnysoHlGLGeXh05KJL9l19HwERMDsOYnEcpYjeQsKUn3y
        hFWcysKcAvfw7V2YjLWn2Tlti1FSU9sFlYbxu2wjRA==
X-Google-Smtp-Source: APXvYqzXVsDy0ze4FRIDwywvutY/B4QAw3R64INVMx+0auCjLO0cktw5lNHc/YQDg6mDs7Vet6xKvfAPTB3hUQaHhXY=
X-Received: by 2002:ab0:210f:: with SMTP id d15mr5424470ual.129.1566476038016;
 Thu, 22 Aug 2019 05:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190822064741.11196-1-chaotian.jing@mediatek.com>
In-Reply-To: <20190822064741.11196-1-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 14:13:21 +0200
Message-ID: <CAPDyKFqEqF_ZHerbkTqqcVBceQvMr_A+-MkbzQJBByhCv9B0fg@mail.gmail.com>
Subject: Re: fix controller busy issue and add 24bits segment support
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 22 Aug 2019 at 08:47, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> the below 2 patches fix controller busy issue when plug out SD card
> and add 24bits segment size support.
>
> Chaotian Jing (2):
>   mmc: mediatek: fix controller busy when plug out SD
>   mmc: mediatek: support 24bits segment size
>
>  drivers/mmc/host/mtk-sd.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
