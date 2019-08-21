Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDEF797E1E
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfHUPHy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 21 Aug 2019 11:07:54 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43398 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbfHUPHy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2019 11:07:54 -0400
Received: by mail-vk1-f194.google.com with SMTP id b11so623100vkk.10
        for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2019 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yoz2RIEoekI97TGDwNDb2cYuY4j2KA9YLKzO29oxa68=;
        b=bKoPdm41C+rt86wgtJEZwgf4WpRLlu7uiVMYEdZBNxIo2ki8MFlGUKMbhVAMe3ieZ1
         SNjpNYLICJ2KbpkDWAm2FWLMqMa+zirJcbb5DwZEqVav4uuxU75qfxkKsNGI+232Fz9s
         W+Nj5uoncJ1iZrtPOlwkzEsBmJgZxnVmGNxO6gNjBFQA1uXHa3TNhZ0/UlEfnrCa8016
         KyX4cHo9xAUIC5oOeui0GM4OhIt21o6BHDroDDUjZYT8CweLAeNBjndyIgwf2smXi16G
         D/EX3MYhAJHrNkw3JEnJ2k7WXEckjsLY9fzCgQJoB7LTSaNvFKwoYvXOEaSEO4pp1IZ5
         YqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yoz2RIEoekI97TGDwNDb2cYuY4j2KA9YLKzO29oxa68=;
        b=Q9HCZw2I/pEe+/fDX6z0RxBVpCnkjLL3dVQ6S5OKxxwmCgktZsRQhI9zvfqH7IKCSK
         PlJMg96YjeRQ1kr9aVv4h4xzSx1dS2CLWl/BkdLfWECHQ/bKHOMtj846s4KKhiqYZaWS
         gciU6vh+obRlhYrtpFdoGeunbaeEpklN2XWvyc3ZJ32EYBkHsbmyfc0H4je9VghxCX7B
         spLs4RWnidB0PZoeBD7W+4u9mOXoCYO3wrZnLUrhWYYYw8c3zA73Maf325BZ1MpPw/gL
         j/mMRoqU/MWrvmS4uVK+X5h12c0qEU9VuSR11NZsOnzquuLWiz8W+BHVeO/tyZoiyxJl
         Zhaw==
X-Gm-Message-State: APjAAAV2shHznHPpyCwWyJrguit5VMi3V8N2VqCUWiDbpKa+gudlvBQE
        FmW9HwrGx7hVhsafsjt3FCDS1+yraqfT1l2dzczF9Q==
X-Google-Smtp-Source: APXvYqxIjlgM9kgim++G2hEIL2HAfU2N3YDY1R7j00eUtzDimP4T6y7m2Y4h8FTVzBRX/pvG3mUHIeFRN6musNiwflc=
X-Received: by 2002:ac5:c4f7:: with SMTP id b23mr5297907vkl.17.1566400073181;
 Wed, 21 Aug 2019 08:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <1558252637-10556-1-git-send-email-chaotian.jing@mediatek.com> <1559438591.25015.0.camel@mhfsdcap03>
In-Reply-To: <1559438591.25015.0.camel@mhfsdcap03>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Aug 2019 17:07:17 +0200
Message-ID: <CAPDyKFofoJKqnchJT-Bty9MMLDviiBWupf+MPmMtv+mRemVXLw@mail.gmail.com>
Subject: Re: fix controller busy issue and add 24bits segment support
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 2 Jun 2019 at 03:23, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> Hi Ulf,
>
> Gentle ping for this patch.

For some reason these patches didn't reach the patchtracker, hence I
have just not seen them.

Could you please re-post this so we can get this merged?

Kind regards
Uffe

>
> On Sun, 2019-05-19 at 15:57 +0800, Chaotian Jing wrote:
> > the below 2 patches fix controller busy issue when plug out SD card
> > and add 24bits segment size support.
> >
> > Chaotian Jing (2):
> >   mmc: mediatek: fix controller busy when plug out SD
> >   mmc: mediatek: support 24bits segment size
> >
> >  drivers/mmc/host/mtk-sd.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> >
>
>
