Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF16473E1F
	for <lists+linux-mmc@lfdr.de>; Wed, 24 Jul 2019 22:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390703AbfGXUWi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 24 Jul 2019 16:22:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36443 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391298AbfGXUWi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jul 2019 16:22:38 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so92454435iom.3
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jul 2019 13:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7b98j1DYhcpfb7OdCLFp27JFdB3a34V6jagTpBUbfA=;
        b=emPr0+o12gzDRDVdDGCZkDSc1awT8Sv7j4Y3PHnjX6+BEM8Ev916Ml6Ya5Ixn59rnj
         bYHRVD4vJpGgnK8uA8ZfT2527Pza1HUFVITP04fOwvVSTVtDbOhp0XyRD+J1U8RCZ7+q
         cQkjHaLlnu1CLlhPM31Ij364/ILIXnU5UveYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7b98j1DYhcpfb7OdCLFp27JFdB3a34V6jagTpBUbfA=;
        b=oKla+Ocxa3TPXg+VJ3liGxfFJQJ6gljxyuFpmstGUxXqcKlj/H2tMBYzQ/09guFaZ9
         9tlauWRtC+SniwU4ijxPOQ9wcTRLhElwqBc1+jjuwOFaOCB+fD49qPogQdyaLEWrMNZp
         COqqhVIM26LOI+7OfQ+vpAdcibNVpCzORlXR/8kgIfvnGUNRQcrFn3bie9IGVJPOg2TF
         99tWDq7Gn+y3Fe9KTDCSe+HC3oEY7IU0QsR9jPr5hwLRAcKUxLc2WEIeQsWoJS+vtfsg
         bheb4lh/uarp9me/zg6rgdEMPut1bjFSdLlEi11rfo8spZOVyUbzryRaHpVvgeZtpszk
         HWJQ==
X-Gm-Message-State: APjAAAVqtHLD3Sx+RynPv+58fzKaaxIvtl0v6V9G1/i3RL9PtTr0Oz4+
        uzxsDGnTy6GUAyZ5Jc8oADLIks4dMMM=
X-Google-Smtp-Source: APXvYqzapp8h0jPwb1r20jg5QIp3CHXX4dfQZ1UIzJMz29OfpjUoegJwIWMzxt2Bt+9BAIfgSlGASQ==
X-Received: by 2002:a6b:4e1a:: with SMTP id c26mr30595875iob.178.1563999757241;
        Wed, 24 Jul 2019 13:22:37 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id v10sm41430970iob.43.2019.07.24.13.22.34
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 13:22:35 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id f4so92385514ioh.6
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jul 2019 13:22:34 -0700 (PDT)
X-Received: by 2002:a5d:8ccc:: with SMTP id k12mr78564964iot.141.1563999754524;
 Wed, 24 Jul 2019 13:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190722193939.125578-3-dianders@chromium.org> <20190724113508.47A356021C@smtp.codeaurora.org>
In-Reply-To: <20190724113508.47A356021C@smtp.codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Jul 2019 13:22:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WAsrBV9PzUz1qPzQru+AkOYZ5hsaWdhNYRTNqUfDeOmQ@mail.gmail.com>
Message-ID: <CAD=FV=WAsrBV9PzUz1qPzQru+AkOYZ5hsaWdhNYRTNqUfDeOmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mwifiex: Make use of the new sdio_trigger_replug()
 API to reset
To:     Kalle Valo <kvalo@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Andreas Fenkart <afenkart@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        netdev <netdev@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Xinming Hu <huxinming820@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Wed, Jul 24, 2019 at 4:35 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Douglas Anderson <dianders@chromium.org> wrote:
>
> > As described in the patch ("mmc: core: Add sdio_trigger_replug()
> > API"), the current mwifiex_sdio_card_reset() is broken in the cases
> > where we're running Bluetooth on a second SDIO func on the same card
> > as WiFi.  The problem goes away if we just use the
> > sdio_trigger_replug() API call.
> >
> > NOTE: Even though with this new solution there is less of a reason to
> > do our work from a workqueue (the unplug / plug mechanism we're using
> > is possible for a human to perform at any time so the stack is
> > supposed to handle it without it needing to be called from a special
> > context), we still need a workqueue because the Marvell reset function
> > could called from a context where sleeping is invalid and thus we
> > can't claim the host.  One example is Marvell's wakeup_timer_fn().
> >
> > Cc: Andreas Fenkart <afenkart@gmail.com>
> > Cc: Brian Norris <briannorris@chromium.org>
> > Fixes: b4336a282db8 ("mwifiex: sdio: reset adapter using mmc_hw_reset")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
>
> I assume this is going via some other tree so I'm dropping this from my
> queue. If I should apply this please resend once the dependency is in
> wireless-drivers-next.
>
> Patch set to Not Applicable.

Thanks.  For now I'll assume that Ulf will pick it up if/when he is
happy with patch #1 in this series.  Would you be willing to provide
your Ack on this patch to make it clear to Ulf you're OK with that?

-Doug
