Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AA8602E89
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Oct 2022 16:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiJROcm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 18 Oct 2022 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiJROcj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2022 10:32:39 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95C5D25B5
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 07:32:36 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id t26so5576843uaj.9
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=447DttLGWlnXVhl3+i4qWwJxEj6tFprhGwRHCuyrWEY=;
        b=oBBsCy6ISl9gtPhcV7dLz4BkVh6F+2c9gD8LeCT2AlvOgAVS60ECD0SwY1gKiuOT6g
         mIsLPTECANZK/H9lboPqPgxCSu8ISGqYSbeFlO2G5zIQHCvTu1xSYznZRNt0v12INqxt
         w+XyiGpI1zpF+zsYqZjZ40efhmuzeadJf0mUo1e35fBz6idd5Tk8M8E0lBlEHNd0/KqW
         Vm/nxv623VQE0qrDz+icVI/ZisJzTkERhJgcjh6YMiNVaH5taq00Jz4z1/2mt3kBbRaJ
         4GnjhEODZfxvRM1qqSfxKqHlXwhlRNS4PMwk0FUH8+miS2Whs6M/KbioR7/bufBdaRLv
         Pawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=447DttLGWlnXVhl3+i4qWwJxEj6tFprhGwRHCuyrWEY=;
        b=o0MRWBQJnnryRzS3wT1SGp034okaacfcSSxskQJuhsQSpoOEeWpmAFovCNy4po1Jd8
         HoFtQoE1D59XMNboBpmcs8Emz4VW1dX9+pbK+j5yI3LbITE5VkORtRafeulBOqt3IywI
         +WPNwvdY5NPXepcCDrden6XIDHqa3KKrBrPLmz1FrrX2Q2NC8N7CUpl+3KD0bi+oDktE
         nhK9uHpevho4uxuOoB6xt0rKjuSI05ZyeVZcUR4btVqnnMtqcderJvtIaE5PnNlxUqfg
         w0ENIBbwekvDs0rGiEAgTC4SRz+lCkICAQck/S2Qkb1pezmzbJmDjvPw5VBSRyZ+aIJP
         Tv2Q==
X-Gm-Message-State: ACrzQf3jRYv0u6BBGDKihsZIkl890GxkvzfQ0IopHjsrszkEuNMxQwQ0
        Dgm65DYLExyzPg9g7SaLnNkDN5D/+P7XdTfqc8s=
X-Google-Smtp-Source: AMsMyM46ZboNcmcGSWOpht5nlSGISBx5S1Mp9MstxHi1WGKF0ZghqkTOrpJuyyyIK9m2Dvn/Oxb+wiykIo7nLF2GFGc=
X-Received: by 2002:ab0:25d4:0:b0:3c1:c353:31cb with SMTP id
 y20-20020ab025d4000000b003c1c35331cbmr1695763uan.63.1666103555234; Tue, 18
 Oct 2022 07:32:35 -0700 (PDT)
MIME-Version: 1.0
Sender: fadilaminumuhammad@gmail.com
Received: by 2002:a59:c924:0:b0:31b:d3d3:500e with HTTP; Tue, 18 Oct 2022
 07:32:34 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Tue, 18 Oct 2022 07:32:34 -0700
X-Google-Sender-Auth: 2uMgSEGpAVQOg6P_NNw0tWmNs1A
Message-ID: <CANJEunA-otqMRcRU-GJof=vsUt6gb0x3z2o+dq3ny0OrvzusVg@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Best Regard

Mrs. Margaret
