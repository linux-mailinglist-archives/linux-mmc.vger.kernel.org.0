Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E51F61D5
	for <lists+linux-mmc@lfdr.de>; Sun, 10 Nov 2019 00:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfKIXJ2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 9 Nov 2019 18:09:28 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36087 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfKIXJ2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Nov 2019 18:09:28 -0500
Received: by mail-qk1-f193.google.com with SMTP id d13so8268180qko.3
        for <linux-mmc@vger.kernel.org>; Sat, 09 Nov 2019 15:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+yAuFLkyFzHxuj6u/Y2vMndpKo/T7dmoHDxRZB96dk=;
        b=mQXVTdbNw9r0US7ZVkLOJGF8fQ7ubvTGqxipy9H0CFjQLv8pf7fMwsaY4RfHofj0wK
         Kd9KoPoOy0vYS2J0Iuy/x3cFBusXvp2+680RGeRQRJinAjU0I+ATEhyo9awbjPcRftGe
         53c0WP2qucfUSoEqOIz6KZhNt9cdyMq+0ptyVSGNaF5sp98Sem2XSL2fwzhfrU/UxNzv
         cUNOntNwlm5gpJPJurHgsre8DfOQuFJ0iNHbel0FliBory6YcGlYr8ua7C+Z+/A8K25W
         3oLERZ8OTmHfaIOYCQxIgkklv5R43z5oXt/9QQeSInC46jYhl/MC4GWVIXTpy2HnCf0i
         OHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+yAuFLkyFzHxuj6u/Y2vMndpKo/T7dmoHDxRZB96dk=;
        b=KeVeTJJ3xFx+fFytNL03dT3LtE8/LuZTxggd7MaTNpUhir7N/tvC4o0OA0nH7LiL4G
         AFZ+I6uZAwkbzqtM0Vf8K2CZdkr1LbGOSQzEYg74GVhhbF2jzmIr5eITWK28OEAsRn8J
         +Y1IH90bA5ZoMaQKCLrWqxv+Ke97J8ZzPsk6MblRzmCd/mXFE8lcarNgQpN56/m9YvSb
         l3pt8xy/B6C54nvr1z6ikADB5obdWI0AsjFmERlbxsL+ddDkcKQdlYzrspkg71Sf3Wfc
         z7xh17e+J52JBOoQ9M6PVCRRAz5P/FZ21V++3WK5BGa9uXJuWOaw0BlOerbq9VC/VQru
         V3UA==
X-Gm-Message-State: APjAAAWlR+n02roU1NxhmO1Y4x/qjDIYSXYYPUxf3CilAg6IjDAqRAXE
        YFgnO2Wyk5XHbYQAxHBCS8rYjJ/lp6+gJlkHjs0=
X-Google-Smtp-Source: APXvYqz9MyHVv8Inp0+RK9hmJwbPE6jXN7AwfuJP+pV4Oa2w3rEO1Pi8iJPQZ6+eWI6VQzMfNgVR76d2urxQi6Sydvk=
X-Received: by 2002:a37:9585:: with SMTP id x127mr4180988qkd.146.1573340966103;
 Sat, 09 Nov 2019 15:09:26 -0800 (PST)
MIME-Version: 1.0
References: <20191024141634.19287-1-lapeddk@gmail.com> <20191024141634.19287-2-lapeddk@gmail.com>
 <MN2PR04MB6991A80C5592DBB67AA0F18FFC7F0@MN2PR04MB6991.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB6991A80C5592DBB67AA0F18FFC7F0@MN2PR04MB6991.namprd04.prod.outlook.com>
From:   Lars Pedersen <lapeddk@gmail.com>
Date:   Sun, 10 Nov 2019 00:09:15 +0100
Message-ID: <CAKd8=Gv1N2HmcMX3fbZtTnRUm0X84hfZ-+h0deXs1d_K3np0bg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mmc-utils: Support MANUAL_EN and AUTO_EN in
 BKOPS_EN register
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "michael.heimpold@i2se.com" <michael.heimpold@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I'm sorry that I have missed one of your previous comments. From your
comments I'll create a more simple patch that takes the old bkops_en
function that can set bit 0 and 1.

The kernel driver checks for both AUTO_EN and MANUAL_EN in
mmc_decode_ext_csd but only have to do something when MANUAL_EN is set
in mmc_run_bkops. So I don't think the driver cares if we try to set
both bits.

But I also did test on a sandisk emmc where I could flip AUTO_EN back
and forth. Setting the AUTO_EN bit stopped having an effect when I had
set the MANUAL_EN bit. So maybe a line in the help section should
mention this.

On Mon, 4 Nov 2019 at 13:50, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> Hi Lars,
>
> >
> > The BKOPS_EN register in eMMC 5.1 now has two fields AUTO_EN and
> > MANUAL_EN.
> >
> > Signed-off-by: Lars Pedersen <lapeddk@gmail.com>
> You didn't responded to my previous comments -
> See https://www.spinics.net/lists/linux-mmc/msg56320.html
> Also, The 0/1 is no longer needed.
>
> Thanks,
> Avri

Kinds regards,
Lars Pedersen
