Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED52153194
	for <lists+linux-mmc@lfdr.de>; Wed,  5 Feb 2020 14:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgBENST (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 5 Feb 2020 08:18:19 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:47039 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBENST (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Feb 2020 08:18:19 -0500
Received: by mail-lf1-f49.google.com with SMTP id z26so1437411lfg.13
        for <linux-mmc@vger.kernel.org>; Wed, 05 Feb 2020 05:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EIOMLYphMJpNA+7/cnaMKo4NunF1Filqifru8THYp3U=;
        b=sTE7J6DQIsGv0QoWvKETreLGv/z9NWRkt1ySeLStEXXNquRqTGI5xQkolWVEXK4XSN
         2anrWWTg3/tF8e2gsqsz2I2lAHrkPDYr8dpECqPq+ZpDlZRVGeMJVX6+nLfTaA/RBvZc
         2kWvSUP3ojXsh0P+Fo7p71Y3nu1cTQcQqys7obQzxOOweeJhPzzaJwpFgVovRiqzqDN+
         cDi9BcXQ8+zVYP0S95/zt/UyD1QRCkigSM+bg3vg001YMpTtGXERdnWI7grWJJfEM7Vj
         gyTRSjEIp1vyb6XGWiarxzW6/VNikU349eFyxeK40J236APIetGGBWtl5vncRIY6O+u0
         TLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EIOMLYphMJpNA+7/cnaMKo4NunF1Filqifru8THYp3U=;
        b=QO8OwiWaE19ECikNXzJIDvT9TT3uPC0Owdd4POX4IMesvuBaA9uTg/PPAlKb2YB9Vb
         AwrX8LsMHBjdij9l5fA6uKtCqpkYoGTpVx4fEtymq61Hrh4w+e3BFHpKbizd7u/UvYfX
         9R0753/b+V/sWeCunAiLphd9HKkkBNlIHFzbY3dJdYAoprax9xvPFw7ftLxnTZ+iLiZ0
         WPiZwRP7+mQZVASM8UgWjjtlJ5yptHbqzn2+bFxhZyuWYAJCZEjut8xcrbvduP5tOwQ1
         RHNGmr6QqvjttqAt9P0afyQ3DnquDBbAwPpkl4/TTI6kgXvsyS/syK3HqNQd1FjPx9/X
         bbGg==
X-Gm-Message-State: APjAAAUAAAiTfOL/XdUbj/q81nH5+fTcBS+KkGN4TbPM5lS4VrAOl8Lv
        6HHHuV3ou4cZVLpgurzF2joQiUi6889OzEAxFsU=
X-Google-Smtp-Source: APXvYqz7hg238lNYDFj0O0BaiuXgC/SGZ9yyGOhY3T6SKPMpUxvxkI0EumUC/b9aAUMMrIH1Q4mOqdZDvkQKc2KYa6I=
X-Received: by 2002:a19:3f51:: with SMTP id m78mr17503275lfa.70.1580908696708;
 Wed, 05 Feb 2020 05:18:16 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
 <20200205092653.GB2737@bogon.m.sigxcpu.org>
In-Reply-To: <20200205092653.GB2737@bogon.m.sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 5 Feb 2020 10:18:10 -0300
Message-ID: <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
Subject: Re: sdhci timeout on imx8mq
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Guido,

On Wed, Feb 5, 2020 at 6:26 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> I've seen the same occasionally on the librem 5 with older linux-next as
> well. Do you have a good reproducer?

Yes, with linux-next I always get this timeout by just booting the
kernel and waiting 1 or 2 minutes without any activity.

Regards,

Fabio Estevam
