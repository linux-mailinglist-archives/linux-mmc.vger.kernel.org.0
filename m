Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422375BB081
	for <lists+linux-mmc@lfdr.de>; Fri, 16 Sep 2022 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIPPqp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 16 Sep 2022 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiIPPql (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2022 11:46:41 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2F5B285A
        for <linux-mmc@vger.kernel.org>; Fri, 16 Sep 2022 08:46:39 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id c3so23115168vsc.6
        for <linux-mmc@vger.kernel.org>; Fri, 16 Sep 2022 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=eMRl7M+KbFRvw1pT8JFw3a+LKSgCZjr5U3TtB9Qh21GdS2xdZWp2/hPKRjLFg/iXkz
         cwlJmGwqX9C11ynoBGljXOQiXz5SOH+042xZwc+4yCJASirWL9HvtlEImXvDRxsYuVzk
         AYtLqLadEROIvCrJhjXqe4skZuWtH2n/PWfKF5MmQNzuPLIHYmTdZGHKBqL7qAiaqIwm
         IQv41xOGtXwvuqfZ2mWStmDTFo7+VL/uWzZUKCaFe1910rMijcA7WlWIC836ydImHzKj
         hArMHU158UHAphtVqPT63oOMEe4u9pzFi1Mi3IYp9Q1xSs8cTiqT3KE0y38dqDofpXIs
         akrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=02n03oQuwCmlBUOPeKqI1byPookNfX1CKmlyA4hdUQ13ZpoBVk3rUuP4rOphxy5BlX
         J3pwzka+Ndr3dvHx/rG0PdvAlfoXx6lBrC7/S9Ih/LXNNoLopGlHTKJtJEphlu3RgNNX
         uMAjZPiW+3gXzbc5OB4r6/zloxAWua/s8xbIqYZl4MoGEZyzIYem/SqNr8OFWsrJ/viT
         6U2BcwCtCdX7nu9liXAQZwzwu0sWbYzK5WCG+2xBlMLIEgCYFt5jQbJBZjr3YBTIuhtt
         BsKqxNkgV5fNV4v9CT18wXzWlX4iIX6GIj+a5MmZfJPLcdkWAsW8gP+DIf/IzY1xhhfH
         MPUg==
X-Gm-Message-State: ACrzQf0fjN0hAVao5bFQFe+DU4m82L/cQoxAajr6FP7ZySvuceQ67DmL
        jj24/JeB7tAr2g1ZoYofvvKP+3z2iUgD7N+WFes=
X-Google-Smtp-Source: AMsMyM5V8BXW7dqah3GqHhSSsG94vJvPfUe6JaxahAMdP+MDEZE4ws/G4GLG72/NMS2DS5Hv+K8xCYrqAyWCQSi3v/0=
X-Received: by 2002:a67:ac09:0:b0:388:70e9:63a0 with SMTP id
 v9-20020a67ac09000000b0038870e963a0mr2291507vse.56.1663343199105; Fri, 16 Sep
 2022 08:46:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f6d9:0:0:0:0:0 with HTTP; Fri, 16 Sep 2022 08:46:38
 -0700 (PDT)
Reply-To: maryalbertt00045@gmail.com
From:   Mary Albert <alassisidemion@gmail.com>
Date:   Fri, 16 Sep 2022 16:46:38 +0100
Message-ID: <CAG8=Qaiv8VPxj67PXt14qL-6_xr3KR0Fh5vCqb0JuuQRNrkwMQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

-- 
Hello,
how are you?
