Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A3D6BC71
	for <lists+linux-mmc@lfdr.de>; Wed, 17 Jul 2019 14:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfGQMh1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 17 Jul 2019 08:37:27 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37495 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQMh1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jul 2019 08:37:27 -0400
Received: by mail-vs1-f65.google.com with SMTP id v6so16353232vsq.4
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jul 2019 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GM4LMg5DxA3aVeM/FeVPYgivowoVv44kavryRmWQg9Q=;
        b=F1sATKUE73kD3GX6xoZ9PNlA/+c60avhYPfVveH8kdYL/CLLJVhGcHX4ND64YvMwPO
         HSwYJGVKQ1cIgaHIuEGBACEkfKexDPe3bdUxlgf7d/WrUmNwFfGRHymcK00rv1P375lq
         FI9/FPE3aMCHSGe+L4ndLkFnb1kVSKXQaC8IiDurx2HXgeqg1t+dky43lnNokArTQaIL
         cpuvZxRTKDcBK15vGn1GXq+s8k8DwUMh4a0e+jvVPbvOHgG84Wyytg9ebKIQV3TKD42o
         QQg2YqeXAXOb1iUZAOiDBRjdFMSf/d3sxOUqS1ScFUYeGXi45AtU/buZWnbiL0xKsLTa
         8t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GM4LMg5DxA3aVeM/FeVPYgivowoVv44kavryRmWQg9Q=;
        b=Dks38LXTpI2CV709HKYDyncUQYWuFWGRV/O4viLnLcut9qa9y9RoM8Iprd3djVh8SU
         8WV1zR7be6NYekrrBsFRkUUp2MzcGzzfonJ6mHotwRj2hsETFpGrK2hBywBjGqOpxYF0
         34F3pPjw8n9c70+Oyd328SRd/0CYFKkHA+u8Ueg0NaLgVpVc/j7QxJtiK+yB9nkRJx7L
         Z1R+RKeijBY7xHa67rcyGVhgw/i6YG0+Eiy2G3LXIX+bO/hgm0wruYHNrHdJYSNez6Xa
         nWAEgI1EW5G0JrOqAGWp5jPkKEcLHRAAsqp49cgbez3R4zLFE3UIk7v1mOgV/Oiq9mD/
         sAVg==
X-Gm-Message-State: APjAAAVLTjBFhINUqIDi7Ksf8Z0Lr2yXF/RoL8KubxsSm1gprU+88CEN
        LQdydW11/ROGeKS1wwT72uoS27xHjD9bSgZetXxoDQ==
X-Google-Smtp-Source: APXvYqxepvRU7WsZo4ENik5VcOLOqTE7Rq1L9T/V+SxO+YL5F5nzY9w3kcKinSrnLvajKNlfCIhRdx7Wg0vPxVQV1FQ=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr24134539vsp.191.1563367046019;
 Wed, 17 Jul 2019 05:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190715164217.27297-1-ulf.hansson@linaro.org> <8b54d001-0c85-08d5-41f7-23a91522a5ce@st.com>
In-Reply-To: <8b54d001-0c85-08d5-41f7-23a91522a5ce@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 17 Jul 2019 14:36:49 +0200
Message-ID: <CAPDyKFp+5e6s3_RtQeoaMZhzkDw0A0aage3kYOejJSjsxwJ8Tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mmci: Drop re-read of MMCISTATUS for busy status
To:     Jean Nicolas GRAUX <jean-nicolas.graux@st.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Jul 2019 at 12:16, Jean Nicolas GRAUX
<jean-nicolas.graux@st.com> wrote:
>
> Hello Ulf, all,
>
> For testing purpose, I cherry-picked your patch on top of a 4.19.30 basis.
> (I apologize as it's a bit old. I miss time to do a rebase on current
> linux-next right now.)

No worries about the old kernel, for this change, I think it should be
suufient good as base.

>
> Unfortunately, I got a kernel crash applying it :(

Huh.

Is it crashing because it fails to mount the rootfs on the SD/MMC card?

>
> As you may know, ST sta1295/sta1385 SoC embeds the same pl08x variant
> than one in U8500.
> So It looks like double-checking again mmci status to make sure busy
> flag is still set
> just before proceeding for busy end is required in our case.

Yeah, actually I have a u8500 on my desk now, so I will also test the
patch to see what goes on. Didn't have the time to do it earlier.

My guess is that, at the point when we received the IRQ for a command
that has been sent, and then reading the MMCISTATUS register in
mmci_irq(), the card has not yet started to signal busy on DAT1 and
hence the busy status bit isn't set yet. This leads to that we will
never enable the busy end mask, but just completing the request
directly.

Anyway, let me check and see if I can confirm it.

>
> Regards.
> Jean-Nicolas.

Thanks a lot for helping out testing and reporting the problem!

[...]

Kind regards
Uffe
