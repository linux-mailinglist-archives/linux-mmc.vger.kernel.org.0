Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1412FDBDE3
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2019 08:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504372AbfJRGym (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Oct 2019 02:54:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38087 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504371AbfJRGym (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2019 02:54:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id j31so7649937qta.5
        for <linux-mmc@vger.kernel.org>; Thu, 17 Oct 2019 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1zxBK4MG0oEJKpuDH6kcwKbZMnNjx3WUdNM0cN1GA8=;
        b=CdRg2x/bBHBAOe9XZT8eUwOLaLvl8x4dvs4Ld4p4uwn9ZOrbi1NseBe0nH4sU/zMXK
         0qySDE3CXFSYnLsE5TLMCy5VX8vV+Y7/VC+VScPudpVZ4qrSx9NEcov4BKOJZ0m5RZ/8
         th9hZvz1aiGwkE8aNpY6inzMQFiM2MAkWJNOsjN0oZL50Wx+M5l/tJoPawYJpoBthro8
         0zCW4C9ZIk935tMs34bzsZLrSwtCFVTet3O/vQp/H3iiRXsG0af1yXYdHLb0IWszyxSo
         DTV8LrU3GO/9+9nffms6CWcSwMS2I/rFPfmrC4Vyqisdzv+NKkO1EXCuw1swalpkJWoF
         vSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1zxBK4MG0oEJKpuDH6kcwKbZMnNjx3WUdNM0cN1GA8=;
        b=PrylqTcxYNzorL+0ywTlvPOj0uKK6HmI18uc4gTCYmn+Y1NmxGcXMmU+LN5psoh+X+
         NTnaTHCDm39WR572gHcF6Oe8Bey05F3ClH5qA6hB773kzqbuUvbo2OJm7iCBPvW+XY2x
         Fr1c0XGDCiaeFmngzlRdzcBIpcxU7b2Xl+iz/BLeVNNr0fSuejOiW94wkgSs/klaK605
         rgvsl5ngV7KgdhCsh3Z28r101yj2/GYB4dw2efvwCBNXIVnshECCUBO3yRhNzfh5sOvT
         KYBbby641yYCW+jHJEs4OLKDCgpXjFNz8itXNSCx8xDfYUUjOASSVos+DINxXrK0u2sy
         iroQ==
X-Gm-Message-State: APjAAAXPaIX2LdDluPtyR0lcNTFVUN/xtFBI3JSId8nWl4jwxofTRpg2
        cuEj0esfExJ3hy/XHg2LcYzQbhod+2SK39fIaN2Zp5kO
X-Google-Smtp-Source: APXvYqzQgp/PaxFFyTt6R1daunXVgx8zsjHEsiLgvwDjyiFoN1vo7mP+HuSwGEiEALWzpuf+i3gpmdO/v8aYZTnRiiQ=
X-Received: by 2002:a0c:e90b:: with SMTP id a11mr8384286qvo.32.1571381681287;
 Thu, 17 Oct 2019 23:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191016111542.31358-1-laa@kamstrup.com> <20191016111542.31358-3-laa@kamstrup.com>
 <MN2PR04MB6991625FB8093E29605880F2FC6D0@MN2PR04MB6991.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB6991625FB8093E29605880F2FC6D0@MN2PR04MB6991.namprd04.prod.outlook.com>
From:   Lars Pedersen <lapeddk@gmail.com>
Date:   Fri, 18 Oct 2019 08:54:30 +0200
Message-ID: <CAKd8=GtBJtdifnhVXs9s+7KJRDTWjDN_+4if79=wooU0xw9U4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc-utils: Support for bkops start when manual
 background operation is used.
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "michael.heimpold@i2se.com" <michael.heimpold@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thanks for the review. I'll create a V2 with the missing signing.
Regarding BKOPS_START the standard tells:

7.4.81 "Writing any value to this field shall manually start
background operations. Device shall stay busy till no
more background operations are needed"

So I don't think it makes sense to have an unset, since it just acts
as a trigger register and blocks until done.

/Lars Pedersen

> > From: Lars Pedersen <lapeddk@gmail.com>
> Proper signing
>
> >
> > Add bkops start functionality when BKOPS_EN[0](MANUAL_EN) is set.
>
>
> > +       ret = write_extcsd_value(fd, EXT_CSD_BKOPS_START, BKOPS_START);
> You may want to allow to unset it as well,
> otherwise you'll need to reset the platform to do so.
>
> Thanks,
> Avri
