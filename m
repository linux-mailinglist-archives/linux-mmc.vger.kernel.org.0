Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C8D68D500
	for <lists+linux-mmc@lfdr.de>; Tue,  7 Feb 2023 12:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjBGLAa (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 7 Feb 2023 06:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjBGLA0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2023 06:00:26 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FEF39CFB
        for <linux-mmc@vger.kernel.org>; Tue,  7 Feb 2023 03:00:24 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso1369640pju.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Feb 2023 03:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8+jhmIIz48dIXQX2IFPY0M3iWQXpZf8pO+LrMnazejU=;
        b=hMhZBrkwn9mu5rwO8P/wWBjO2hseEQQzHCJR2ZiThOOEH2glFvgReRPEFc6st2394h
         KJToZcnRQCop96jBGOSm+FA6D8/nUtORcBXIj+aI2pqB5s4kh+qkXg9yYTVeeX2VLhP+
         7yEuqZYYWjbxlzQrAywc/9namt2wZI0VALX6GfWH53wjYbKOBfzrMdgBObVwi6PkGtsL
         xzYhfX66LrbNCKS67UbfEQXkmFwQadAvEjYHkMULhFbxkhWglOBz+VXTZ4oqbDWMZEtQ
         sPiDLdzJLh0waxyM3hMvfubtsZ2vuUWFuXRpe7Gvoz9s1mIBwv6uYRV0LvO006WHGZie
         WoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+jhmIIz48dIXQX2IFPY0M3iWQXpZf8pO+LrMnazejU=;
        b=5qm2AvbFTKZFGWasrg6ojLuqeGc6YYgBjFvksKS35Zflvr99WcN+hJ5gtH1bDfX5Q3
         CJZf/b2KdByZRslhGC8QjJAdbX/crxCeqSDWjl2MD5Lp5PrUrwwSdscMxMpLtQW+LTqy
         MNlT9gcAISY1vScBEZX3fiJ6nfkJFAkkr45RlgFU5rDsBftzunoHfu3I+srXbW/JnH+y
         PyapaM8caliCJL/TYfP7QSeRcPImAU1MQ4PL9ZPaO1FCMMLpPDTKFHMDp/dY0PAyZcui
         KOiXV6sH0EUMsRAHmWA4akIf+6dWcL8Kovej/3y+FIedA2iuWTga+fyjgJ+4YK6xPSnZ
         HjkQ==
X-Gm-Message-State: AO0yUKWsVldulr+HrngVBZ+bRy0Gkd1MXqm2hDhNoT6S+tqnmUvqhLyx
        CWHx589dDuRkwlrZIt/7LTD3vLQta6KhghUdFNOEGw==
X-Google-Smtp-Source: AK7set83msoaMiTXRrS5ta9B0EOybiGY0PCDj8JRYR9tI5TDFdGRWQJC3vfZF78+7WvToBf8qOiWISFUOlFdc4SubaE=
X-Received: by 2002:a17:90a:d24f:b0:230:d1d5:2041 with SMTP id
 o15-20020a17090ad24f00b00230d1d52041mr1289670pjw.109.1675767624059; Tue, 07
 Feb 2023 03:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw> <20221213090047.3805-6-victor.shih@genesyslogic.com.tw>
In-Reply-To: <20221213090047.3805-6-victor.shih@genesyslogic.com.tw>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Feb 2023 11:59:47 +0100
Message-ID: <CAPDyKFrE8CBPu5GsnBrt9U4=UnCVdhR3UAeAC6Ab8P1EXVsHAw@mail.gmail.com>
Subject: Re: [PATCH V6 05/24] mmc: core: Add definitions for SD UHS-II cards
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Jason Lai <jason.lai@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 13 Dec 2022 at 10:01, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Add UHS-II specific data structures for commands and defines for
> registers, as described in Part 1 UHS-II Addendum Version 1.01.
>
> UHS-II related definitions are listed below:
>   1. UHS-II card capability: sd_uhs2_caps{}
>   2. UHS-II configuration: sd_uhs2_config{}
>   3. UHS-II Command structure: uhs2_command{}
>   4. UHS-II register I/O address and register field definitions: sd_uhs2.h
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

[...]

> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -23,6 +23,14 @@ enum mmc_blk_status {
>         MMC_BLK_NEW_REQUEST,
>  };
>
> +struct uhs2_command {
> +       u16     header;
> +       u16     arg;
> +       __be32  *payload;
> +       u32     payload_len;
> +       u32     packet_len;
> +};
> +
>  struct mmc_command {
>         u32                     opcode;
>         u32                     arg;
> @@ -109,6 +117,11 @@ struct mmc_command {
>         unsigned int            busy_timeout;   /* busy detect timeout in ms */
>         struct mmc_data         *data;          /* data segment associated with cmd */
>         struct mmc_request      *mrq;           /* associated request */
> +
> +       struct uhs2_command     *uhs2_cmd;      /* UHS2 command */
> +       u8                      *uhs2_resp;     /* UHS2 native cmd resp */
> +       u8                      uhs2_resp_len;  /* UHS2 native cmd resp len */
> +       u8                      uhs2_tmode0_flag; /* UHS2 transfer mode flag */

I forgot to comment on this flag in my earlier reply. It looks like
the flag is being set for "MMC_CMD_ADTC" commands. This makes me
wonder, why can't we keep using cmd->flags to check this, rather than
adding a new flag solely for UHS2? Or is there a problem with this?

I will continue to comment around this at patch7 too.

[...]

Kind regards
Uffe
