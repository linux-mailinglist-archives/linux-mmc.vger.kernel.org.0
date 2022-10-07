Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D265F75B1
	for <lists+linux-mmc@lfdr.de>; Fri,  7 Oct 2022 10:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJGI6I (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 7 Oct 2022 04:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJGI6H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2022 04:58:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764F8D0CF3
        for <linux-mmc@vger.kernel.org>; Fri,  7 Oct 2022 01:58:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso4207101pjk.1
        for <linux-mmc@vger.kernel.org>; Fri, 07 Oct 2022 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YlOA1ajfEjIreDWiK3PXxp/clko/mhMc0BPVeuvrVKk=;
        b=lIxmb3rQ+YeVSlfpT0wR7Zf/QIz9jo2frkBn0Xe5WONGs/re2ir9B7xWRjolnSmcI+
         5WjrtSD4IeL8tYaunK/UO0JXtUAO4bLMUVMPOmWFepEzljp50a9K5/8dSUmfMAHi/RBr
         G80Cmvw3K6L7jw7f0eV3+07LlqDNfLzNOm1awA1BBE8/Qzqf2cOS+auyGqE/EtYEGiwt
         cnwh9Yhpk4A/fAj36Xk2MBomeYOysVEHNSNE51ZKjAhPzz2K7Sd1KhrtsFiU8FRAkKI+
         jxcDnThl9cteBUkkVQs6kyu5SNRVjsqEcpCjzE5L6NsgfRDvoAfOaYre1ewHyQHVqla7
         a5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YlOA1ajfEjIreDWiK3PXxp/clko/mhMc0BPVeuvrVKk=;
        b=Te94wnKzF78XYH5RuGVfUBvtrVFr9oXM4j9WhyWU3Ck2yWJSHV6nBrn0RMrRjdVZDl
         LTznMrj4bt76m4Z4XPB9MVktcbPeXYh5mPG2YXXQSy7dUUhjXfzCDIo9aV06Ioqj4aZz
         3TI7wUlZVrPq4jyLJ03fP2MePdneIShDYGvGRxy2bLhngIHCKE87SN8ou7eOin3R1oKC
         Dw++F64LI9BEnG+S+rJ85C1G9ktnkqe0rKEB+kRnLEDWJ3jSS6kPnOg2gq1OT1sES8UA
         3BSa5bgOq+/mqBdTUw1m0NgrRuHvFm74D5u/h7k3pLMQBR+cMOh9Uyw9WHaOG6sKgpwi
         6zJA==
X-Gm-Message-State: ACrzQf1+ilxc6pxEwya/JCsUatGt3Aqwx2jArZKW2/VQtCEM4RPz3WJr
        XShRZ5Iru5TK/I/X/H4qmuLBID+NrquA6e+v0U/tgm/Qg5o=
X-Google-Smtp-Source: AMsMyM7Pfm6aZcJS1S3WOES8NOOW4/G8hU+6EnlQpuwBrvyqVzTF2vQ6zv7O7GW4LhTWk1b1dD8s/g7ppJU4OuNpcxA=
X-Received: by 2002:a17:90b:1b06:b0:202:cce0:2148 with SMTP id
 nu6-20020a17090b1b0600b00202cce02148mr15386629pjb.84.1665133084980; Fri, 07
 Oct 2022 01:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220928110755.849275-1-biju.das.jz@bp.renesas.com>
 <Yzsb7SCkNDyCghLg@shikoro> <CAPDyKFpkfr9Rtrz6DF1zYxEypTYqyJyRsTyxHToBJu+1AFB+Hg@mail.gmail.com>
 <Yz71AT6MbgrTPP6X@shikoro> <OS0PR01MB592243C904D5BD74BD9B2C2D865C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592243C904D5BD74BD9B2C2D865C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Oct 2022 10:57:28 +0200
Message-ID: <CAPDyKFr25JGGw-bW8F+7=4h6Obssks_016dcVZD7phA2Hih=Kw@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: renesas_sdhi: Fix rounding errors
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 6 Oct 2022 at 18:07, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Wolfram Sang & Ulf Hansson,
>
> > Subject: Re: [PATCH v5] mmc: renesas_sdhi: Fix rounding errors
> >
> >
> > > Or is this just a general bugfix that we should tag for stable?
> >
> > I'd think this because I assume there is no commit causing the
> > rounding errors. But maybe Biju has something to add?
>
> There is rounding error present since commit [1], but no HW at that time to
> introduce the error. Then we added RZ/G2L support and we started seeing this
> issue after [2].
>
> So may be treat this an enhancement patch or fixes to [1] or [2]

Alright, I have added a fixes tag [1] and a stable tag - and applied
it for fixes, thanks!

Kind regards
Uffe

>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/renesas_sdhi_core.c?h=v6.0&id=bb6d3fa98a418b071c5f735e75558604f5f4af66
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/clk/renesas/r9a07g044-cpg.c?h=v6.0&id=b289cdecc7c3e25e001cde260c882e4d9a8b0772
>
> Cheers,
> Biju
>
